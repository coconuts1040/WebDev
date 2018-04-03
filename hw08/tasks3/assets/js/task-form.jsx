// Taken from Nat Tuck's lecture notes
import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from './api';

function TaskForm(props) {
    function update(ev) {
        let target = $(ev.target);
        console.log(target);
        let data = {};
        data[target.attr('name')] = target.val();
        let action = {
            type: 'UPDATE_FORM',
            data: data,
        };
        console.log(action);
        props.dispatch(action);
    }

    function submit(ev) {
        console.log("Creating task, rounding progress down to the nearest 15 minutes");
        let props_rounded = parseInt(props.form.progress) - (parseInt(props.form.progress) % 15);
        let data = {};
        data["progress"] = props_rounded;
        let action = {
            type: 'UPDATE_FORM',
            data: data,
        };
        //        props.dispatch(action);

        //        let new_form = props.form;
        //        new_form['progress'] = props_rounded;
        //        console.log("new form", new_form);

        api.submit_task(props.form);
        console.log(props.form);
    }

    let users = _.map(props.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
    return <div style={{padding: "4ex"}}>
        <h2>New Task</h2>
        <FormGroup>
            <Label for="user_id">Assigned to:</Label>
            <Input type="select" name="user_id" value={props.form.user_id} onChange={update}>
                { users }
            </Input>
        </FormGroup>
        <FormGroup>
            <Label for="title">Title:</Label>
            <Input type="textarea" name="title" value={props.form.title} onChange={update} />
        </FormGroup>
        <FormGroup>
            <Label for="description">Description:</Label>
            <Input type="textarea" name="description" value={props.form.description} onChange={update} />
        </FormGroup>
        <FormGroup>
            <Label for="progress">Progress:</Label>
            <Input type="number" name="progress" value={props.form.progress} onChange={update} />
        </FormGroup>
        <FormGroup>
            <Label for="completed">Completed?</Label>
            <span className="col-1 offset-1">
                <Input type="checkbox" name="completed" value={props.form.completed} onChange={update} />
            </span>
        </FormGroup>
        <Button onClick={submit} color="primary">Create</Button>
    </div>;
}

function state_to_props(state) {
    console.log("re-render", state);
    return {
        form: state.form,
        users: state.users,
    };
}

export default connect(state_to_props)(TaskForm);
