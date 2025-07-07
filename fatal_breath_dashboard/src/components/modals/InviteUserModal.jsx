import { Modal, Form, Button, message } from "antd";
import AsyncSelect from "react-select/async";
import { useState } from "react";
import { toggleInvitation, searchUsers } from "../../root/api";

const InviteUserModal = ({ visible, onClose, houseId }) => {
    const [form] = Form.useForm();
    const [selectedUser, setSelectedUser] = useState(null);

    const handleFinish = async () => {
        if (!selectedUser) {
            message.error("Please select a user to invite.");
            return;
        }

        console.log("Inviting:", selectedUser);
        await toggleInvitation(houseId, selectedUser.value);
        message.success(`Invitation sent to ${selectedUser.label}`);
        form.resetFields();
        setSelectedUser(null);
        onClose();
    };

    const loadOptions = async (inputValue) => {
        if (!inputValue) return [];
        const data = await searchUsers(houseId, inputValue);

        return data.users.map((user) => ({
            label: `${user.name} (${user.email})`,
            value: user.id,
        }));

    };

    return (
        <Modal
            title="Invite User"
            open={visible}
            onCancel={() => {
                form.resetFields();
                setSelectedUser(null);
                onClose();
            }}
            footer={null}
            centered
        >
            <Form layout="vertical" form={form} onFinish={handleFinish}>
                <Form.Item label="Search User">
                    <AsyncSelect
                        cacheOptions
                        loadOptions={loadOptions}
                        defaultOptions
                        value={selectedUser}
                        onChange={setSelectedUser}
                        placeholder="Type name or email..."
                    />
                </Form.Item>
                <Button type="primary" htmlType="submit" block>
                    Send Invitation
                </Button>
            </Form>
        </Modal>
    );
};

export default InviteUserModal;
