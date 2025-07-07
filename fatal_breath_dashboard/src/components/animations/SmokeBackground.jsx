import React, { useEffect, useRef } from 'react';
import { Application } from '@pixi/app';
import { Container } from '@pixi/display';
import { Sprite } from '@pixi/sprite';
import { Texture } from '@pixi/core';
import { BLEND_MODES } from '@pixi/constants';

const smokeImage = 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/95637/Smoke-Element.png';

const getRandomFloat = (min, max) => Math.random() * (max - min) + min;

const SmokeBackground = ({
    particleCount = 150,
    direction = 'up', // 'up', 'down', 'left', 'right', 'random'
}) => {
    const containerRef = useRef(null);
    const mousePos = useRef({ x: null, y: null });

    useEffect(() => {
        let app;
        let isDestroyed = false;
        const smokeParticles = [];

        const initPixi = () => {
            const container = containerRef.current;
            if (!container) return;

            app = new Application({
                backgroundAlpha: 0,
                width: container.clientWidth,
                height: container.clientHeight,
                autoDensity: true,
                resolution: window.devicePixelRatio || 1,
            });

            if (isDestroyed || !container) {
                app.destroy(true, { children: true });
                return;
            }

            container.appendChild(app.view);
            Object.assign(app.view.style, {
                position: 'absolute',
                top: 0,
                left: 0,
                width: '100%',
                height: '100%',
                zIndex: 1,
                pointerEvents: 'none',
                opacity: 0.6,
            });

            const smokes = new Container();
            app.stage.addChild(smokes);
            const smokeTexture = Texture.from(smokeImage);

            for (let i = 0; i < particleCount; i++) {
                const particle = new Sprite(smokeTexture);
                particle.anchor.set(0.5);
                particle.alpha = getRandomFloat(0.1, 0.5);
                particle.blendMode = BLEND_MODES.SCREEN;
                particle.tint = 0xffffff;
                particle.rotation = Math.random() * Math.PI * 2;
                particle._rotationSpeed = getRandomFloat(0.0005, 0.003) * (Math.random() < 0.5 ? 1 : -1);

                const isLeft = Math.random() < 0.5;
                particle.x = isLeft
                    ? getRandomFloat(-50, 100)
                    : container.clientWidth + getRandomFloat(-100, 50);
                particle.y = container.clientHeight + getRandomFloat(-50, 50);

                particle._baseScale = getRandomFloat(0.25, 1.0);
                particle.scale.set(particle._baseScale);

                // Direction-based drift
                switch (direction) {
                    case 'up':
                        particle._driftX = getRandomFloat(-0.5, 0.5);
                        particle._driftY = getRandomFloat(-1.5, -0.5);
                        break;
                    case 'down':
                        particle._driftX = getRandomFloat(-0.5, 0.5);
                        particle._driftY = getRandomFloat(0.5, 1.5);
                        break;
                    case 'left':
                        particle._driftX = getRandomFloat(-1.5, -0.5);
                        particle._driftY = getRandomFloat(-0.5, 0.5);
                        break;
                    case 'right':
                        particle._driftX = getRandomFloat(0.5, 1.5);
                        particle._driftY = getRandomFloat(-0.5, 0.5);
                        break;
                    case 'random':
                    default:
                        particle._driftX = getRandomFloat(-0.8, 0.8);
                        particle._driftY = getRandomFloat(-1.5, -0.5);
                        break;
                }

                particle._flickerPhase = Math.random() * Math.PI * 2;
                particle._flickerSpeed = getRandomFloat(0.02, 0.07);
                particle._original = { x: particle._driftX, y: particle._driftY };

                smokes.addChild(particle);
                smokeParticles.push(particle);
            }

            app.ticker.add(() => {
                const now = performance.now();
                const width = container.clientWidth;
                const height = container.clientHeight;

                smokeParticles.forEach((p) => {
                    if (mousePos.current.x !== null) {
                        const dx = p.x - mousePos.current.x;
                        const dy = p.y - mousePos.current.y;
                        const dist = Math.sqrt(dx * dx + dy * dy);
                        const maxDist = 150;

                        if (dist < maxDist) {
                            const force = (1 - dist / maxDist) * 0.8;
                            p.x += dx * force * 0.05;
                            p.y += dy * force * 0.05;
                        } else {
                            p.x += p._driftX;
                            p.y += p._driftY;
                        }
                    } else {
                        p.x += p._driftX;
                        p.y += p._driftY;
                    }

                    p.rotation += p._rotationSpeed;
                    p.scale.set(p._baseScale * (1 + 0.1 * Math.sin(now * 0.002 + p._flickerPhase)));
                    p.alpha = p.alpha * 0.95 + 0.05 * (0.4 + 0.05 * Math.sin(now * p._flickerSpeed + p._flickerPhase));

                    if (p.x < -150) p.x = width + 150;
                    if (p.x > width + 150) p.x = -150;
                    if (p.y < -150) p.y = height + 150;
                    if (p.y > height + 150) p.y = -150;
                });
            });

            const handleMouseMove = (e) => {
                const rect = container.getBoundingClientRect();
                mousePos.current = {
                    x: e.clientX - rect.left,
                    y: e.clientY - rect.top,
                };
            };

            const handleMouseLeave = () => {
                mousePos.current = { x: null, y: null };
            };

            container.addEventListener('mousemove', handleMouseMove);
            container.addEventListener('mouseleave', handleMouseLeave);

            const handleResize = () => {
                app.renderer.resize(container.clientWidth, container.clientHeight);
            };

            window.addEventListener('resize', handleResize);

            app._cleanup = () => {
                container.removeEventListener('mousemove', handleMouseMove);
                container.removeEventListener('mouseleave', handleMouseLeave);
                window.removeEventListener('resize', handleResize);
            };
        };

        initPixi();

        return () => {
            isDestroyed = true;
            if (app) {
                app._cleanup?.();
                app.destroy(true, { children: true });
            }
        };
    }, [particleCount, direction]);

    return <div ref={containerRef} className="smoke-container" />;
};

export default SmokeBackground;
