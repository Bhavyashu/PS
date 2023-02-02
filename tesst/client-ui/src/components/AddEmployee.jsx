import React, { useState } from 'react';
import { Form, Button, Input, Select, message, Row, PageHeader } from "antd";
import EmpService from '../services/employeeApi';
const FormItem = Form.Item;
const Option = Select.Option;


const AddEmployee = () => {
    const [form] = Form.useForm();
    const [loading, setLoading] = useState(false);
    const addEmployee = async (values) => {
        try {
            setLoading(true)
            let resp = await EmpService.AddNewEmployee(values)
            const respJSON = JSON.parse(resp)
            
            if (respJSON.status === 'ERROR') {
                message.error(respJSON.description);
            } else if (respJSON.success === false) {
                message.error(respJSON.message);
            } else {
                message.success(respJSON.description);
                form.resetFields();
            }
        } catch (err) {
            message.error(err.message);
        } finally {
            setLoading(false);
        }
    }

    return (
        <>
            <PageHeader className='site-page-header' title='Add new property' />
            <Row type="flex" justify="center" align="middle" className='form-wrapper'>
                <Form
                    form={form}
                    autoComplete="off"
                    labelCol={{ span: 8 }}
                    wrapperCol={{ span: 16 }}

                    onFinish={addEmployee}

                    onFinishFailed={(error) => {
                        console.log({ error });
                    }}
                >

                    <FormItem
                        name="Type"
                        label="Select Type"
                        rules={[
                            {
                                required: false,
                                message: 'Please select employee job title',
                            },
                        ]}
                    >
                        <Select style={{ width: '100%', textAlign:'left' }}
                            placeholder="Type Of Property">
                            <Option value="Commercial">Commercial</Option>
                            <Option value="Residential">Residential</Option>
                            <Option value="Agricultural Land">Agricultural Land</Option>
                        </Select>
                    </FormItem>
                    <FormItem
                        name="PropID"
                        label="Property ID"
                        rules={[
                            {
                                required: true,
                                message: "Please enter propety  ID",
                            },
                            { message: "Please enter property Id" },
                        ]}
                        hasFeedback
                    >
                        <Input placeholder="Enter your Property Details " />
                    </FormItem>
                    <FormItem
                        name="firstName"
                        label="First Name"
                        rules={[
                            {
                                required: true,
                                message: "Please enter first name",
                            },
                            { type: "text", message: "Please enter first name" },
                        ]}
                        hasFeedback
                    >
                        <Input placeholder="Enter first name" />
                    </FormItem>

                    <FormItem
                        name="lastName"
                        label="Last Name"
                        rules={[
                            {
                                required: true,
                                message: "Please enter last name",
                            },
                            { type: "text", message: "Please enter last name" },
                        ]}
                        hasFeedback
                    >
                        <Input placeholder="Enter last name" />
                    </FormItem>

                    <FormItem
                        name="Price"
                        label="price"
                        rules={[
                            {
                                required: false,
                                message: "Please enter price",
                            },
                            { type: "text", message: "Please enter blood group" },
                        ]}
                        hasFeedback
                    >
                        <Input placeholder="Enter price" />
                    </FormItem>

                    <FormItem
                        name="mobile"
                        label="Mobile Number"
                        rules={[
                            {
                                required: false,
                            },
                            { message: "Please enter a valid Mobile number" },
                        ]}
                        hasFeedback
                    >
                        <Input placeholder="Enter your Mobile number" />
                    </FormItem>
                    <FormItem
                        name="address"
                        label="Address"
                        rules={[
                            {
                                required: false,
                            },
                            { type: "text", message: "Please enter address" },
                        ]}
                        hasFeedback
                    >
                        <Input placeholder="Enter address" />
                    </FormItem>
                    <FormItem>
                        <Button type="primary" htmlType="submit" loading={loading} className="save-btn">
                            Save
                        </Button>
                    </FormItem>
                </Form>
            </Row>
        </>
    )

}

export default AddEmployee
