// Taken from Nat Tuck's lecture notes
import React from 'react';
import { Card, CardBody } from 'reactstrap';

export default function Task(params) {
    let task = params.task;
    return <Card>
        <CardBody>
            <div>
                <p><strong>Title:</strong> { task.title }</p>
                <p><strong>Assigned to:</strong> { task.user.name }</p>
                <p><strong>Description:</strong> { task.description }</p>
                <p><strong>Progress:</strong> { task.progress }</p>
                <p><strong>Completed:</strong> { task.completed }</p>
            </div>
        </CardBody>
    </Card>;
}
