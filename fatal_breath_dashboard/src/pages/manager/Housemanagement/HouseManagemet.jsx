import { PlusOutlined, DeleteOutlined, SearchOutlined, AppstoreOutlined, HomeOutlined, EnvironmentOutlined, CalendarOutlined, BankOutlined, ShopOutlined, HddOutlined } from "@ant-design/icons";
import { Button, Input, Card, Row, Col, Tooltip, Popconfirm, Typography, Empty, Skeleton } from "antd";
import { createHouse, loadHouses, deleteHouse } from "../../../root/api";
import AddHouseModal from "../../../components/modals/AddHouseModal";
import { useState, useEffect, useCallback } from "react";
import { useNavigate } from "react-router-dom";

const { Title, Text } = Typography;

const HouseManagement = () => {
  const [houses, setHouses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchText, setSearchText] = useState("");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const navigate = useNavigate();

  const fetchHouses = useCallback(async () => {
    setLoading(true);
    try {
      const { houses: rawHouses } = await loadHouses();
      const mapped = rawHouses.map((house) => ({
        ...house,
        key: house.id.toString(),
      }));
      setHouses(mapped);
    } catch (error) {
      console.error("Failed to load houses:", error.response?.data || error.message);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchHouses();
  }, [fetchHouses]);

  const handleAddHouse = async (data) => {
    try {
      const { house } = await createHouse(data.name, data.city, data.country);
      setHouses((prev) => [
        ...prev,
        { ...house, key: house.id.toString() },
      ]);
      setIsModalOpen(false);
    } catch (error) {
      console.error("Failed to add house:", error.response?.data || error.message);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteHouse(id);
      setHouses((prev) => prev.filter((house) => house.key !== id));
    } catch (error) {
      console.error("Failed to delete house:", error.response?.data || error.message);
    }
  };

  const handleNavigateToDetails = (id) => {
    navigate(`${id}`);
  };

  const formatDate = (dateString) => {
    if (!dateString) return "N/A";
    return new Date(dateString).toLocaleDateString("en-US", {
      year: "numeric",
      month: "short",
      day: "numeric",
    });
  };

  const filteredData = houses.filter(({ name, city, country }) => {
    const query = searchText.toLowerCase();
    return (
      name.toLowerCase().includes(query) ||
      city.toLowerCase().includes(query) ||
      country.toLowerCase().includes(query)
    );
  });

  const paginatedData = filteredData;

  // Function to get random house icon and color
  const getHouseIcon = (houseName, index) => {
    const icons = [
      { icon: <HomeOutlined />, color: '#1890ff' },
      { icon: <BankOutlined />, color: '#52c41a' },
      { icon: <HddOutlined />, color: '#fa8c16' },
      { icon: <ShopOutlined />, color: '#eb2f96' },
    ];

    // Use house name and index to get consistent icon
    const iconIndex = (houseName.length + index) % icons.length;
    return icons[iconIndex];
  };

  // Function to generate gradient background
  const getCardGradient = (index) => {
    const gradients = [
      'linear-gradient(45deg, #002766 0%, #124a99 70%, #165dbe 90%)',
      'linear-gradient(90deg, #165dbe 0%, #124a99 60%, #002766 100%)',
      'linear-gradient(135deg, #002766 0%, #165dbe 75%, #124a99 95%)',
    ];
    return gradients[index % gradients.length];
  };

  return (
    <div className="house-management-container">
      {/* Header Section */}
      <div className="header-section">
        <Row gutter={[16, 16]} align="middle" justify="space-between">
          <Col xs={24} sm={16} md={12} lg={8}>
            <Input
              placeholder="Search houses by name, city, or country..."
              value={searchText}
              onChange={(e) => setSearchText(e.target.value)}
              prefix={<SearchOutlined />}
              allowClear
              size="large"
            />
          </Col>
          <Col xs={24} sm={8} md={6} lg={4}>
            <Button
              type="primary"
              icon={<PlusOutlined />}
              size="large"
              block
              onClick={() => setIsModalOpen(true)}
              disabled={houses.length >= 6}
            >
              Add House
            </Button>
          </Col>
        </Row>
      </div>

      {/* Cards Section */}
      {loading ? (
        <Row gutter={[24, 24]}>
          {[...Array(6)].map((_, index) => (
            <Col xs={24} sm={24} md={8} lg={8} xl={8} key={index}>
              <Card>
                <Skeleton active avatar paragraph={{ rows: 4 }} />
              </Card>
            </Col>
          ))}
        </Row>
      ) : paginatedData.length === 0 ? (
        <Empty
          image={Empty.PRESENTED_IMAGE_SIMPLE}
          description={
            searchText ? "No houses match your search" : "No houses found"
          }
        />
      ) : (
        <Row gutter={[24, 24]}>
          {paginatedData.map((house, index) => {
            const houseIcon = getHouseIcon(house.name, index);
            const cardGradient = getCardGradient(index);

            return (
              <Col xs={24} sm={24} md={8} lg={8} xl={8} key={house.key}>
                <Card
                  hoverable
                  className="house-card"
                  styles={{ body: { padding: 0 } }}
                  actions={[
                    <Tooltip title="View Details" key="details">
                      <div style={{ width: '100%', display: 'flex', justifyContent: 'center' }}>
                        <Button
                          type="text"
                          icon={<AppstoreOutlined />}
                          onClick={() => handleNavigateToDetails(house.key)}
                          className="card-action-button"
                          style={{ color: "#1890ff", fontWeight: "500" }}
                        >
                          Details
                        </Button>
                      </div>
                    </Tooltip>,
                    <Popconfirm
                      title="Delete House"
                      description="Are you sure you want to delete this house?"
                      onConfirm={() => handleDelete(house.key)}
                      okText="Yes"
                      cancelText="No"
                      key="delete"
                    >
                      <Tooltip title="Delete House">
                        <div style={{ width: '100%', display: 'flex', justifyContent: 'center' }}>
                          <Button
                            type="text"
                            danger
                            icon={<DeleteOutlined />}
                            className="card-action-button"
                          >
                            Delete
                          </Button>
                        </div>
                      </Tooltip>
                    </Popconfirm>,
                  ]}

                >
                  {/* Header with gradient background */}
                  <div
                    className="card-header"
                    style={{ background: cardGradient }}
                  >
                    {/* Decorative circles */}
                    <div className="decorative-circle-large" />
                    <div className="decorative-circle-small" />

                    {/* House Icon */}
                    <div className="house-icon-container">
                      <div className="icon-wrapper">
                        <div className="icon">
                          {houseIcon.icon}
                          {/* <HouseIcon /> */}
                        </div>
                      </div>
                    </div>

                    {/* House Name */}
                    <Title
                      level={4}
                      className="house-name"
                      ellipsis={{ tooltip: house.name }}
                    >
                      {house.name}
                    </Title>
                  </div>

                  {/* Content */}
                  <div className="card-content">
                    {/* Location Info */}
                    <div className="location-info">
                      <EnvironmentOutlined className="location-icon" />
                      <Text className="location-text">
                        {house.country}, {house.city}
                      </Text>
                    </div>

                    {/* Creation Date */}
                    <div className="creation-date">
                      <CalendarOutlined className="date-icon" />
                      <Text className="date-text">
                        Created: {formatDate(house.createdAt || house.created_at)}
                      </Text>
                    </div>
                  </div>
                </Card>
              </Col>
            );
          })}
        </Row>
      )}
      {isModalOpen && (
        <AddHouseModal
          visible={true}
          onClose={() => setIsModalOpen(false)}
          onAddHouse={handleAddHouse}
        />
      )}

    </div>
  );
};

export default HouseManagement;