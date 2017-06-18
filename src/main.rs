extern crate xcb;

fn main() {
    let (conn, _) = xcb::Connection::connect(None).unwrap();
    loop {
        let event = conn.wait_for_event();
        match event {
            None => { break; }
            Some(event) => {
                let r = event.response_type() & !0x80;
                match r {
                    xcb::KEY_PRESS => {
                        let key_press : &xcb::KeyPressEvent = xcb::cast_event(&event);
                        println!("Key '{}' pressed", key_press.detail());
                        break;
                    },
                    _ => {}
                }
            }
        }
    }
}
