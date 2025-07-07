import { Modal, Form, Input, Button } from "antd";
import { useEffect } from "react";

const AddHouseModal = ({ visible, onClose, onAddHouse }) => {
    const [form] = Form.useForm();

    const handleFinish = async (values) => {
        await onAddHouse(values);
        form.resetFields();
    };

    useEffect(() => {
        if (!visible) {
            form.resetFields();
        }
    }, [visible, form]);

    return (
        <Modal
            title="Add House"
            open={visible}
            onCancel={onClose}
            footer={null}
            centered
        >
            <Form layout="vertical" form={form} onFinish={handleFinish}>
                <Form.Item
                    name="name"
                    label="House Name"
                    rules={[
                        { required: true, message: "House name is required." },
                        { max: 20, message: "Must be 20 characters or fewer." },
                        {
                            pattern: /^[A-Za-z0-9\s-]+$/,
                            message: "Only letters, numbers, spaces, and hyphens are allowed.",
                        },
                    ]}
                >
                    <Input placeholder="e.g. Sunset" maxLength={20} />
                </Form.Item>

                <Form.Item
                    name="country"
                    label="Country"
                    rules={[
                        { required: true, message: "Country is required." },
                        { max: 20, message: "Must be 20 characters or fewer." },
                        {
                            pattern: /^[A-Za-z\s]+$/,
                            message: "Only letters and spaces are allowed.",
                        },
                    ]}
                >
                    <Input placeholder="e.g. Lebanon" maxLength={20} />
                </Form.Item>

                <Form.Item
                    name="city"
                    label="City"
                    rules={[
                        { required: true, message: "City is required." },
                        { max: 20, message: "Must be 20 characters or fewer." },
                        {
                            pattern: /^[A-Za-z\s]+$/,
                            message: "Only letters and spaces are allowed.",
                        },
                    ]}
                >
                    <Input placeholder="e.g. Beirut" maxLength={20} />
                </Form.Item>

                <Button type="primary" htmlType="submit" block>
                    Add
                </Button>
            </Form>
        </Modal>
    );
};

export default AddHouseModal;
