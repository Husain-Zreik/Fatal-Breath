import { useEffect } from "react";

export default function ParticlesBackground() {
    useEffect(() => {
        const canvas = document.getElementById("particlesField");
        if (!canvas) return;
        const ctx = canvas.getContext("2d");

        let particlesArray = [];
        let animationFrameId;

        const resizeCanvas = () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        };
        resizeCanvas();
        window.addEventListener("resize", resizeCanvas);

        class SmokeParticle {
            constructor() {
                this.reset();
            }

            reset() {
                // Randomly choose a side: 0=left, 1=right, 2=bottom
                this.side = Math.floor(Math.random() * 3);

                this.size = Math.random() * 70 + 30;
                this.alpha = Math.random() * 0.2 + 0.05;

                switch (this.side) {
                    case 0: // left side
                        this.x = -this.size;
                        this.y = Math.random() * canvas.height;
                        this.speedX = Math.random() * 0.5 + 0.2;  // move right
                        this.speedY = Math.random() * -0.2 + 0.1; // slight vertical drift
                        break;
                    case 1: // right side
                        this.x = canvas.width + this.size;
                        this.y = Math.random() * canvas.height;
                        this.speedX = -(Math.random() * 0.5 + 0.2); // move left
                        this.speedY = Math.random() * -0.2 + 0.1;   // slight vertical drift
                        break;
                    case 2: // bottom side
                    default:
                        this.x = Math.random() * canvas.width;
                        this.y = canvas.height + this.size;
                        this.speedX = Math.random() * 0.4 - 0.2;  // slight horizontal drift
                        this.speedY = -(Math.random() * 0.7 + 0.5); // move up
                        break;
                }
            }

            update() {
                this.x += this.speedX;
                this.y += this.speedY;

                // Reset if particle moves outside visible area
                if (
                    this.x < -this.size ||
                    this.x > canvas.width + this.size ||
                    this.y < -this.size
                ) {
                    this.reset();
                }
            }

            draw() {
                const gradient = ctx.createRadialGradient(
                    this.x,
                    this.y,
                    0,
                    this.x,
                    this.y,
                    this.size
                );
                gradient.addColorStop(0, `rgba(217, 231, 251, ${this.alpha})`);
                gradient.addColorStop(1, "rgba(217, 231, 251, 0)");

                ctx.beginPath();
                ctx.fillStyle = gradient;
                ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
                ctx.fill();
            }
        }


        function initParticles() {
            particlesArray = [];
            for (let i = 0; i < 50; i++) {
                particlesArray.push(new SmokeParticle());
            }
        }

        let lastTime = 0;
        const fpsInterval = 1000 / 30;

        function animate(time) {
            const elapsed = time - lastTime;
            if (elapsed > fpsInterval) {
                lastTime = time;
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                particlesArray.forEach((p) => {
                    p.update();
                    p.draw();
                });
            }
            animationFrameId = requestAnimationFrame(animate);
        }

        initParticles();
        animate();

        return () => {
            cancelAnimationFrame(animationFrameId);
            window.removeEventListener("resize", resizeCanvas);
        };
    }, []);

    return (
        <canvas
            id="particlesField"
            style={{
                position: "absolute",
                top: 0,
                left: 0,
                zIndex: 0,
                width: "100%",
                height: "100%",
                pointerEvents: "none"
            }}
        />
    );
}