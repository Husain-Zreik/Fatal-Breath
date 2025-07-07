import React, { useEffect, useState } from 'react';
import {
    CheckOutlined,
    CloseOutlined,
    StopOutlined,
    InboxOutlined,
    SendOutlined,
    HomeOutlined,
    CalendarOutlined,
    CommentOutlined,
} from '@ant-design/icons';
import {
    Row, Col, Card, Button, Tooltip, Popconfirm, Typography, Skeleton, Pagination, message,
    Space,
} from 'antd';
import { loadRequests, proccessRequest, toggleInvitation } from '../../../root/api';

const { Text, Title } = Typography;
const ITEMS_PER_PAGE = 6;

const RequestsPage = () => {
    const [requests, setRequests] = useState([]);
    const [invitations, setInvitations] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [activeTab, setActiveTab] = useState('requests');
    const [currentPage, setCurrentPage] = useState(1);

    // Fetch data function
    const refreshData = async () => {
        setLoading(true);
        setError(null);
        try {
            const response = await loadRequests();
            const allItems = response.requests || [];

            const filteredRequests = allItems.filter(
                (item) => item.type === 'Request' && item.status === 'Pending'
            );
            const filteredInvitations = allItems.filter(
                (item) => item.type === 'Invitation' && item.status === 'Pending'
            );

            setRequests(filteredRequests);
            setInvitations(filteredInvitations);
            setCurrentPage(1); // Reset to first page on data reload
        } catch (err) {
            console.error('Failed to load requests:', err);
            setError('Failed to load requests');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        // Load data initially with simulated delay
        (async () => {
            await new Promise((resolve) => setTimeout(resolve, 1000));
            refreshData();
        })();
    }, []);

    // Handlers for accept, decline, cancel
    const handleAccept = async (houseId, userId) => {
        try {
            await proccessRequest(houseId, userId, 'Accepted');
            message.success('Request accepted.');
            refreshData();
        } catch (err) {
            console.error(err);
            message.error('Failed to accept request.');
        }
    };

    const handleDecline = async (houseId, userId) => {
        try {
            await proccessRequest(houseId, userId, 'Declined');
            message.success('Request declined.');
            refreshData();
        } catch (err) {
            console.error(err);
            message.error('Failed to decline request.');
        }
    };

    const handleCancel = async (houseId, userId) => {
        try {
            await toggleInvitation(houseId, userId);
            message.success('Invitation cancelled.');
            refreshData();
        } catch (err) {
            console.error(err);
            message.error('Failed to cancel invitation.');
        }
    };

    const getProfileImage = (user) => {
        return user?.profile_image
            ? user.profile_image
            : `https://ui-avatars.com/api/?name=${encodeURIComponent(user?.name || 'User')}&background=002766&color=fff&size=64`;
    };

    const formatDate = (date) =>
        new Date(date).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
        });

    const getCardGradient = (index) => {
        const gradients = [
            'linear-gradient(45deg, #002766 0%, #124a99 70%, #165dbe 90%)',
            'linear-gradient(90deg, #165dbe 0%, #124a99 60%, #002766 100%)',
            'linear-gradient(135deg, #002766 0%, #165dbe 75%, #124a99 95%)',
        ];
        return gradients[index % gradients.length];
    };

    const currentData = activeTab === 'requests' ? requests : invitations;
    const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
    const paginatedData = currentData.slice(startIndex, startIndex + ITEMS_PER_PAGE);

    return (
        <div className="container">
            {/* Tabs */}
            <div className="mb-4">
                <div
                    className="d-flex flex-column flex-sm-row gap-2 align-items-start align-items-sm-center"
                >
                    <Button
                        type={activeTab === 'requests' ? 'primary' : 'default'}
                        icon={<InboxOutlined />}
                        onClick={() => {
                            setActiveTab('requests');
                            setCurrentPage(1);
                        }}
                        className="w-100 w-sm-auto"
                    >
                        Requests
                        {!loading && (
                            <span className="badge bg-white text-primary ms-2">{requests.length}</span>
                        )}
                    </Button>
                    <Button
                        type={activeTab === 'invitations' ? 'primary' : 'default'}
                        icon={<SendOutlined />}
                        onClick={() => {
                            setActiveTab('invitations');
                            setCurrentPage(1);
                        }}
                        className="w-100 w-sm-auto"
                    >
                        Invitations
                        {!loading && (
                            <span className="badge bg-white text-secondary ms-2">{invitations.length}</span>
                        )}
                    </Button>
                </div>
            </div>


            {/* Content */}
            {loading ? (
                <Row gutter={[24, 24]}>
                    {[1, 2, 3].map((item) => (
                        <Col xs={24} sm={24} md={12} lg={8} xl={8} key={item}>
                            <Card className="skeleton-card" hoverable>
                                <Skeleton active avatar paragraph={{ rows: 3 }} />
                            </Card>
                        </Col>
                    ))}
                </Row>
            ) : error ? (
                <div className="container mt-5">
                    <div className="alert alert-danger d-flex align-items-center" role="alert">
                        <i className="fas fa-exclamation-circle me-2"></i>
                        <div>{error}</div>
                    </div>
                </div>
            ) : paginatedData.length === 0 ? (
                <div className="text-center py-5 my-4 bg-light rounded-3">
                    {activeTab === 'requests' ? (
                        <InboxOutlined
                            style={{ fontSize: '48px', color: '#bfbfbf', marginBottom: '16px' }}
                        />
                    ) : (
                        <SendOutlined
                            style={{ fontSize: '48px', color: '#bfbfbf', marginBottom: '16px' }}
                        />
                    )}
                    <Title level={4} className="mb-2">
                        {activeTab === 'requests'
                            ? 'No pending membership requests'
                            : 'No invitations sent yet'}
                    </Title>
                    <Text type="secondary">
                        {activeTab === 'requests'
                            ? 'When users request to join your properties, they will appear here.'
                            : 'Invitations you send to users will appear here.'}
                    </Text>
                </div>
            ) : (
                <>
                    <Row gutter={[24, 24]}>
                        {paginatedData.map((item, index) => (
                            <Col xs={24} sm={24} md={12} lg={8} xl={8} key={item.id}>
                                <Card
                                    hoverable
                                    className="house-card"
                                    styles={{ body: { padding: 0 } }}
                                    actions={
                                        activeTab === 'requests'
                                            ? [
                                                <Tooltip title="Accept Request" key="accept">
                                                    <Button
                                                        type="text"
                                                        icon={<CheckOutlined />}
                                                        onClick={() =>
                                                            handleAccept(item.house_id, item.user_id)
                                                        }
                                                        style={{ color: '#52c41a', fontWeight: '500' }}
                                                    >
                                                        Accept
                                                    </Button>
                                                </Tooltip>,
                                                <Tooltip title="Decline Request" key="decline">
                                                    <Button
                                                        type="text"
                                                        danger
                                                        icon={<CloseOutlined />}
                                                        onClick={() =>
                                                            handleDecline(item.house_id, item.user_id)
                                                        }
                                                    >
                                                        Decline
                                                    </Button>
                                                </Tooltip>,
                                            ]
                                            : [
                                                <Popconfirm
                                                    title="Cancel Invitation"
                                                    description="Are you sure you want to cancel this invitation?"
                                                    onConfirm={() =>
                                                        handleCancel(item.house_id, item.user_id)
                                                    }
                                                    okText="Yes"
                                                    cancelText="No"
                                                    key="cancel"
                                                >
                                                    <Tooltip title="Cancel Invitation">
                                                        <Button type="text" danger icon={<StopOutlined />}>
                                                            Cancel
                                                        </Button>
                                                    </Tooltip>
                                                </Popconfirm>,
                                            ]
                                    }
                                >
                                    {/* Header */}
                                    <div
                                        className="card-header"
                                        style={{
                                            background: getCardGradient(index),
                                            padding: '16px',
                                        }}
                                    >
                                        <div className="d-flex align-items-center">
                                            <img
                                                src={getProfileImage(item.user)}
                                                className="rounded-circle me-3 border border-2 border-white"
                                                width="64"
                                                height="64"
                                                alt="User"
                                                style={{ objectFit: 'cover' }}
                                            />
                                            <div style={{ overflow: 'hidden' }}>
                                                <Title
                                                    level={4}
                                                    className="mb-1 username-wrapper"
                                                    style={{
                                                        color: 'white',
                                                        marginBottom: '4px',
                                                    }}
                                                >
                                                    {item.user?.name || 'Unknown User'}
                                                </Title>
                                                <Text
                                                    type="secondary"
                                                    style={{
                                                        color: 'rgba(255, 255, 255, 0.7)',
                                                        whiteSpace: 'nowrap',
                                                        overflow: 'hidden',
                                                        textOverflow: 'ellipsis',
                                                        display: 'block',
                                                    }}
                                                >
                                                    {item.user?.email || 'No email'}
                                                </Text>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Content */}
                                    <div className="p-3">
                                        <div className="mb-3">
                                            <div className="d-flex align-items-center mb-2">
                                                <HomeOutlined
                                                    style={{ color: '#1890ff', marginRight: '8px' }}
                                                />
                                                <Text strong ellipsis={{ tooltip: item.house?.name }}>
                                                    {item.house?.name || 'Unknown House'}
                                                </Text>
                                            </div>
                                            <div className="d-flex align-items-center">
                                                <CalendarOutlined
                                                    style={{ color: '#bfbfbf', marginRight: '8px' }}
                                                />
                                                <Text type="secondary">
                                                    {activeTab === 'requests'
                                                        ? 'Requested'
                                                        : 'Invited'}{' '}
                                                    on {formatDate(item.created_at)}
                                                </Text>
                                            </div>
                                        </div>
                                        {item.message && (
                                            <div
                                                style={{
                                                    background: '#f5f5f5',
                                                    padding: '8px',
                                                    borderRadius: '4px',
                                                }}
                                            >
                                                <div className="d-flex align-items-start">
                                                    <CommentOutlined
                                                        style={{
                                                            color: '#bfbfbf',
                                                            marginRight: '8px',
                                                            marginTop: '2px',
                                                        }}
                                                    />
                                                    <Text type="secondary" italic ellipsis={{ tooltip: item.message }}>
                                                        "{item.message}"
                                                    </Text>
                                                </div>
                                            </div>
                                        )}
                                    </div>
                                </Card>
                            </Col>
                        ))}
                    </Row>

                    {/* Pagination */}
                    <div className="d-flex justify-content-center my-4">
                        <Pagination
                            current={currentPage}
                            pageSize={ITEMS_PER_PAGE}
                            total={currentData.length}
                            onChange={(page) => setCurrentPage(page)}
                            showSizeChanger={false}
                        />
                    </div>
                </>
            )}
        </div>
    );
};

export default RequestsPage;
