// Dart is a single-threaded language.
// Dart's single thread runs in what it calls an isolate. Each isolate has its own allocated memory.
// Isolates are able to communicate through messages.
// You can run code concurrently by creating isolates.
// Dart uses an event loop to schedule asynchronous tasks.
// The event loop uses two queues: an event queue and a microtask queue.
// The event queue is for events like a user touching the screen or data coming in from a remote server.
// Dart primarily uses the microtask queue internally to prioritize certain small tasks that can't wait for the tasks in the event queue to finish.
// Synchronous code always runs first and cannot be interrupted. After this comes anything in the microtask queue, and then any tasks in the event queue.

// activate only one line at a time otherwise code will intersperse
void main() {
  // synchronousCode();
  // addingTaskToEventQueue();
  // addingTaskToMicrotaskQueue();
  // runningSynchronousCodeAfterEventQueueTask();
  delayingTasks();
}

void synchronousCode() {
  print('// synchronousCode');

  print('first');
  print('second');
  print('third');
}

// Passing a block of code to Future causes Dart to put that code on the event queue.
// Synchronous code is run first then code in the event queue.
void addingTaskToEventQueue() {
  print('\n// addingTaskToEventQueue');

  print('first');
  Future(
    () => print('second - event queue'),
  );
  print('third');
}

// Synchronous code, then microtask queue, then event queue.
void addingTaskToMicrotaskQueue() {
  print('\n// addingTaskToMicrotaskQueue');

  print('first');
  Future(
    () => print('second - event queue'),
  );
  // Never done in practice. Just for pedagogical reasons.
  Future.microtask(
    () => print('third - microtask queue'),
  );
  print('fourth');
}

// Synchronous code, then event queue.
void runningSynchronousCodeAfterEventQueueTask() {
  print('\n// runningSynchronousCodeAfterEventQueueTask');

  print('first');
  Future(
    () => print('second - event queue'),
  ).then(
    // this is a callback (synchronous code) that gets called after event queue entry finishes
    (value) => print('third - then event queue'),
  );
  Future(
    () => print('fourth - event queue'),
  );
  print('fifth');
}

void delayingTasks() {
  print('\n// delayingTasks');

  print('first');
  Future.delayed(
    Duration(seconds: 2),
    () => print('second'),
  );
  print('third');
}
