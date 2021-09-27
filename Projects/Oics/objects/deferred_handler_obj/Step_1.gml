// Execute any deferred requests:
var maxloop = ds_queue_size(deferred_requests);
while (not ds_queue_empty(deferred_requests)){
    if (maxloop <= 0) break;
    --maxloop;
    
    var value = ds_queue_dequeue(deferred_requests);
    // Not long enough, wait until next frame to try again:
    if (current_time < value[2]){
        ds_queue_enqueue(deferred_requests, value);
        break;
    }
    callv(value[0], value[1]);
}