// Taken from Nat Tuck's lecture notes
import React from 'react';
import { NavLink } from 'react-router-dom';
import { NavItem } from 'reactstrap';

export default function Nav(props) {
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
                User(change)
            </span>
        </nav>
    );
}
