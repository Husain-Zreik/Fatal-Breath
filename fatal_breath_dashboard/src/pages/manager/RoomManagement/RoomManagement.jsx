import { loadRoomsFromAdminHouses, createRoom, deleteRoom } from "../../../root/api";
import AddRoomModal from "../../../components/modals/AddRoomModal";
import InviteUserModal from "../../../components/modals/InviteUserModal"; // 👈 You need to create this
import { Table, Button, Popconfirm, message, Tag } from "antd";
import { DeleteOutlined, UserAddOutlined } from "@ant-design/icons";
import { useParams } from "react-router-dom";
import { useEffect, useState } from "react";

const RoomManagement = () => {
  const { houseId } = useParams();
  const [rooms, setRooms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [isInviteModalOpen, setIsInviteModalOpen] = useState(false); // 👈 New state

  useEffect(() => {
    const fetchRoomsAndHouse = async () => {
      setLoading(true);
      try {
        const roomsData = await loadRoomsFromAdminHouses(houseId);
        setRooms(roomsData);
      } catch (error) {
        console.error("Error loading rooms:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchRoomsAndHouse();
  }, [houseId]);


  const handleAddRoom = async (values) => {
    try {
      const newRoom = await createRoom(values.name, houseId, values.type);

      // Add missing properties if needed
      const normalizedRoom = {
        ...newRoom,
        hasSensor: newRoom.sensor ? true : false,
        sensor: newRoom.sensor || null,
      };

      setRooms((prev) => [...prev, normalizedRoom]);
      setIsAddModalOpen(false);
      message.success("Room added successfully!");
    } catch (error) {
      console.error("Error adding room:", error);
      message.error("Failed to add room.");
    }
  };

  const handleDeleteRoom = async (roomId) => {
    try {
      await deleteRoom(roomId);
      setRooms((prev) => prev.filter((room) => room.id !== roomId));
      message.success("Room deleted successfully!");
    } catch (error) {
      console.error("Error deleting room:", error);
      message.error("Failed to delete room.");
    }
  };

  const columns = [
    {
      title: "Room Name",
      dataIndex: "name",
      key: "name",
    },
    {
      title: "Type",
      dataIndex: "type",
      key: "type",
    },
    {
      title: "Sensor Level (%)",
      key: "sensor",
      render: (_, record) => {
        if (record.hasSensor && record.sensor?.co_level !== undefined) {
          const level = record.sensor.co_level;
          let color = level < 50 ? "green" : level < 75 ? "orange" : "red";
          return <Tag color={color}>{level}%</Tag>;
        }
        return "N/A";
      },
    },
    {
      title: "Actions",
      key: "actions",
      render: (_, record) => (
        <Popconfirm
          title="Are you sure you want to delete this room?"
          onConfirm={() => handleDeleteRoom(record.id)}
          okText="Yes"
          cancelText="No"
        >
          <DeleteOutlined className="delete-icon" />
        </Popconfirm>
      ),
    },
  ];

  return (
    <div className="room-view-container">
      <div style={{ display: "flex", justifyContent: "flex-end", gap: "1rem", marginBottom: 16 }}>
        <Button type="primary" onClick={() => setIsAddModalOpen(true)} disabled={loading}>
          Add Room
        </Button>
        <Button type="primary" onClick={() => setIsInviteModalOpen(true)} disabled={loading}>
          <UserAddOutlined />
          Invite Member
        </Button>
      </div>

      <Table
        loading={loading}
        dataSource={rooms}
        columns={columns}
        rowKey="id"
        pagination={{ pageSize: 10 }}
        size="large"
      />

      {isAddModalOpen && (
        <AddRoomModal
          visible={true}
          onClose={() => setIsAddModalOpen(false)}
          onSubmit={handleAddRoom}
        />
      )}

      {isInviteModalOpen && (
        <InviteUserModal
          visible={true}
          onClose={() => setIsInviteModalOpen(false)}
          houseId={houseId}
        />
      )}

    </div>
  );
};

export default RoomManagement;
