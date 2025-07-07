import { Modal, Form, Input, Select, Button } from "antd";

const AddRoomModal = ({ visible, onClose, onSubmit }) => {
    const [form] = Form.useForm();

    const handleFinish = async (values) => {
        await onSubmit(values);
        form.resetFields();
    };

    return (
        <Modal
            title="Add Room"
            open={visible}
            onCancel={() => {
                form.resetFields();
                onClose();
            }}
            footer={null}
            centered
        >
            <Form layout="vertical" form={form} onFinish={handleFinish}>
                <Form.Item name="name" label="Room Name" rules={[{ required: true }]}>
                    <Input />
                </Form.Item>
                <Form.Item name="type" label="Room Type" rules={[{ required: true }]}>
                    <Select placeholder="Select type">
                        <Select.Option value="Bedroom">Bedroom</Select.Option>
                        <Select.Option value="Livingroom">Living Room</Select.Option>
                        <Select.Option value="Kitchen">Kitchen</Select.Option>
                        <Select.Option value="Bathroom">Bathroom</Select.Option>
                    </Select>
                </Form.Item>
                <Button type="primary" htmlType="submit" block>
                    Add Room
                </Button>
            </Form>
        </Modal>
    );
};

export default AddRoomModal;
