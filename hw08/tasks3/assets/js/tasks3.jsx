// Taken from Nat Tuck's lecture notes
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider, connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Nav from './nav';
import Feed from './feed';
import Users from './users';
import NewUser from './new_user';
import TaskForm from './task-form';

export default function tasks3_init(store) {
    ReactDOM.render(
        <Provider store={store}>
            <Tasks3 state={store.getState()}/>
        </Provider>,
        document.getElementById('root'),
    );
}

let Tasks3 = connect((state) => state)((props) => {
    return (
        <Router>
            <div>
                <Nav />
                <Route path="/" exact={true} render={() =>
                    <div>
                        <TaskForm users={props.users} root={this} />
                        <Feed tasks={props.tasks} />
                    </div>
                } />
                <Route path="/users" exact={true} render={() =>
                    <Users users={props.users} />
                } />
                <Route path="/users/:user_id" render={({match}) =>
                    <Feed tasks={_.filter(props.tasks, (tt) =>
                        match.params.user_id == tt.user.id )
                    } />
                } />
                <Route path="/users/new" render={() =>
                    <NewUser />
                } />
            </div>
        </Router>
    );
});
