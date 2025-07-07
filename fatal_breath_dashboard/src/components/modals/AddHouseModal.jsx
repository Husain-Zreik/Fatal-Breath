import { Modal, Form, Input, Button } from "antd";
import { useEffect } from "react";

const AddHouseModal = ({ visible, onClose, onAddHouse }) => {
    const [form] = Form.useForm();

    const handleFinish = async (values) => {
        await onAddHouse(values);
        form.resetFields();
    };

    // reset form when modal closes
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
                <Form.Item name="name" label="House Name" rules={[{ required: true }]}>
                    <Input placeholder="e.g. Sunset Estate" />
                </Form.Item>

                <Form.Item name="country" label="Country" rules={[{ required: true }]}>
                    <Input placeholder="e.g. Lebanon" />
                </Form.Item>

                <Form.Item name="city" label="City" rules={[{ required: true }]}>
                    <Input placeholder="e.g. Beirut" />
                </Form.Item>

                <Button type="primary" htmlType="submit" block>
                    Add
                </Button>
            </Form>
        </Modal>
    );
};

export default AddHouseModal;
