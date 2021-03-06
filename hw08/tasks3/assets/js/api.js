// Taken from Nat Tuck's lecture notes
import store from './store';

class Server {
    request_tasks() {
        $.ajax("/api/v1/tasks", {
            method: "get",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            success: (resp) => {
                store.dispatch({
                    type: 'TASKS_LIST',
                    tasks: resp.data,
                });
            },
        });
    }

    request_users() {
        $.ajax("/api/v1/users", {
            method: "get",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            success: (resp) => {
                store.dispatch({
                    type: 'USERS_LIST',
                    users: resp.data,
                });
            },
        });
    }

    submit_task(data) {
        $.ajax("/api/v1/tasks", {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({ token: data.token, task: data }),
            success: (resp) => {
                store.dispatch({
                    type: 'CREATE_TASK',
                    task: resp.data,
                });
            },
        });
    }

    create_user(data) {
        $.ajax("/api/v1/users", {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({ user: data }),
            success: (resp) => {
                store.dispatch({
                    type: 'CREATE_USER',
                    user: resp.data,
                });
            },
        });
    }

    submit_login(data) {
        $.ajax("/api/v1/token", {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify(data),
            success: (resp) => {
                store.dispatch({
                    type: 'SET_TOKEN',
                    token: resp,
                });
            },
        });
    }
}

export default new Server();
