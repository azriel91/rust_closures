# 📦 Stored

Since a closure can be stored, it can be passed around:

```rust
struct JoblessWorker {
    tasks: Vec<fn()>,
}

let task_0 = || println!("create rust");
let task_1 = || println!("create talk");
let task_2 = || println!("talk create rust");

let azriel = JoblessWorker {
    tasks: vec![
        task_0,
        task_1,
        task_2,
    ],
};

azriel.tasks.into_iter().for_each(|f| f());
```
