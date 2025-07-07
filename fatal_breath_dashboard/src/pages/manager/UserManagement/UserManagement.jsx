import { useState, useEffect } from "react";
import { Table, Input, Row, Col, Button, Popconfirm, Avatar } from "antd";
import {
  DeleteOutlined,
  SearchOutlined,
  UserOutlined,
} from "@ant-design/icons";
import { loadMembers, deleteMember } from "../../../root/api";

const UserManagement = () => {
  const [members, setMembers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchText, setSearchText] = useState("");

  useEffect(() => {
    const fetchMembers = async () => {
      setLoading(true); // Start loading
      try {
        const response = await loadMembers();
        const flattenedMembers = [];

        response.members.forEach((member) => {
          member.houses.forEach((house) => {
            flattenedMembers.push({
              key: `${member.id}-${house.id}`,
              id: member.id,
              full_name: member.name,
              email: member.email,
              profile_image: member.profile_image,
              house_id: house.id,
              house_name: house.name,
            });
          });
        });

        setMembers(flattenedMembers);
      } catch (error) {
        console.error("Failed to load members:", error.response?.data || error.message);
      } finally {
        setLoading(false); // Stop loading after fetch
      }
    };

    fetchMembers();
  }, []);


  const handleDelete = async (member) => {
    try {
      await deleteMember(member.house_id, member.id);
      setMembers((prev) =>
        prev.filter(
          (m) => !(m.id === member.id && m.house_id === member.house_id)
        )
      );
    } catch (error) {
      console.error("Failed to delete member:", error.response?.data || error.message);
    }
  };

  const columns = [
    {
      title: "Profile",
      key: "profile_image",
      dataIndex: "profile_image",
      className: "text-center",
      render: (image) => (
        <Avatar
          src={image || undefined}
          icon={!image && <UserOutlined />}
          size={40}
        />
      ),
    },
    {
      title: "Full Name",
      dataIndex: "full_name",
      key: "full_name",
      className: "text-center",
      sorter: (a, b) => a.full_name.localeCompare(b.full_name),
    },
    {
      title: "Email",
      dataIndex: "email",
      key: "email",
      className: "text-center",
      sorter: (a, b) => a.email.localeCompare(b.email),
    },
    {
      title: "House",
      dataIndex: "house_name",
      key: "house_name",
      className: "text-center",
      sorter: (a, b) => a.house_name.localeCompare(b.house_name),
    },
    {
      title: "Actions",
      key: "actions",
      className: "text-center",
      render: (_, record) => (
        <div className="d-flex justify-content-center gap-2">
          <Popconfirm
            title="Are you sure you want to remove this member from this house?"
            onConfirm={() => handleDelete(record)}
            okText="Yes"
            cancelText="No"
          >
            <Button danger size="small">
              Remove
            </Button>
          </Popconfirm>
        </div>
      ),
    },
  ];

  const filteredData = members.filter((member) => {
    const lower = searchText.toLowerCase();
    return (
      member.full_name.toLowerCase().includes(lower) ||
      member.email.toLowerCase().includes(lower) ||
      member.house_name.toLowerCase().includes(lower)
    );
  });

  return (
    <div className="user-management-container">
      <Row gutter={[16, 16]} className="mb-3">
        <Col xs={24} sm={12} md={8}>
          <Input
            placeholder="Search members..."
            value={searchText}
            onChange={(e) => setSearchText(e.target.value)}
            prefix={<SearchOutlined />}
            allowClear
          />
        </Col>
      </Row>

      <Table
        loading={loading}
        dataSource={filteredData}
        columns={columns}
        pagination={{ pageSize: 5 }}
        rowKey="key"
      />
    </div>
  );
};

export default UserManagement;
