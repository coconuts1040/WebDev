// Taken from Nat Tuck's lecture notes
import React from 'react';
import { NavLink } from 'react-router-dom';
import { Form, FormGroup, NavItem, Input, Button } from 'reactstrap';
import { connect } from 'react-redux';
import api from './api';

let LoginForm = connect(({login}) => {return {login};})((props) => {
    function update(ev) {
        let target = $(ev.target);
        let data = {};
        data[target.attr('name')] = target.val();
        props.dispatch({
            type: 'UPDATE_LOGIN_FORM',
            data: data,
        });
    }

    function create_token(ev) {
        api.submit_login(props.login);
        console.log(props.login);
    }

    return <div className="navbar-text">
        <Form inline>
            <FormGroup>
                <Input type="text" name="email" placeholder="email" value={props.login.email} onChange={update} />
            </FormGroup>
            <FormGroup>
                <Input type="password" name="pass" placeholder="password" value={props.login.pass} onChange={update} />
            </FormGroup>
            <Button color="outline-light" onClick={create_token}>Login</Button>
            <a className="btn btn-outline-light" href="/users/new" role="button" to="/users/new">Register</a>
        </Form>
    </div>;
});

let Session = connect(({token}) => {return {token};})((props) => {
    console.log("Session Token", props.token);
    return <div className="navbar-text">
        <span>User id = { props.token.user_id }</span>
        <Form inline>
            <Button color="danger" onClick={location.reload()}>Log Out</Button>
        </Form>
    </div>;
});

function Nav(props) {
    let session_info;

    if (props.token) {
        session_info = <Session token={props.token} />;
    }
    else {
        session_info = <LoginForm />;
    }

    return (
        <nav className="navbar navbar-dark navbar-fixed-top bg-primary navbar-expand">
            <span className="navbar-brand">
                Tasks3
            </span>
            <ul className="navbar-nav mr-auto">
                <NavItem>
                    <NavLink to="/" exact={true} activeClassName="active" className="nav-link">Feed</NavLink>
                </NavItem>
                <NavItem>
                    <NavLink to="/users" href="#" className="nav-link">All Users</NavLink>
                </NavItem>
            </ul>
            <span className="navbar-text">
                { session_info }
            </span>
        </nav>
    );
}

function state_to_props(state) {
    return {
        token: state.token,
    };
}

export default connect(state_to_props)(Nav);
