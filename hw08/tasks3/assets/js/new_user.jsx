import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from './api';

function NewUser(props) {
    function update(ev) {
        let target = $(ev.target);
        let data = {};
        data[target.attr('name')] = target.val();
        let action = {
            type: 'UPDATE_USER_FORM',
            data: data,
        };
        console.log(action);
        props.dispatch(action);
    }

    function submit(ev) {
        api.create_user(props.form);
        console.log(props.form);
    }

    return <div style={{ padding: "4ex" }}>
        <h2>New User</h2>
        <FormGroup>
            <Label for="name">Name:</Label>
            <Input type="textarea" name="name" value={props.form.name} onChange={update} />
        </FormGroup>
        <FormGroup>
            <Label for="email">E-mail:</Label>
            <Input type="textarea" name="email" value={props.form.email} onChange={update} />
        </FormGroup>
        <FormGroup>
            <Label for="password">Enter Password:</Label>
            <Input type="textarea" name="password" value={props.form.password} onChange={update} />
        </FormGroup>
        <Button color="primary" onClick={submit}>Create</Button>
    </div>;
}

function state_to_props(state) {
    console.log("re-render", state);
    return {
        form: state.user_form,
    };
}

export default connect(state_to_props)(NewUser);
