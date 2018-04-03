// Taken from Nat Tuck's lecture notes
import React from 'react';
import Task from './task';

export default function Feed(params) {
    let tasks = _.map(params.tasks, (tt) => <Task key={tt.id} task={tt} />);
    return <div>
        { tasks }
    </div>;
}
