module guestbook::guestbook;

use std::string::{Self, String};

const MAX_MESSAGE_LENGTH: u64 = 256;

public struct Message has store {
    sender: address,
    content: String
}

public struct GuestBook has key, store {
    id: UID,
    messages: vector<Message>,
    no_of_messages: u64

}

fun init(ctx: &mut TxContext) {
    let guestbook: GuestBook = GuestBook {
        id: object::new(ctx),
        messages: vector::empty<Message>(),
        no_of_messages : 0,
    };

    sui::transfer::share_object(guestbook);
}

public fun post_message(guestbook: &mut GuestBook, message: Message) {
    vector::push_back(&mut guestbook.messages,message);
    guestbook.no_of_messages = guestbook.no_of_messages + 1;
}

public fun create_message(message: String, ctx: &mut TxContext): Message{
    assert!(string::length(&message) <= MAX_MESSAGE_LENGTH, 0);

    Message {
        sender: ctx.sender(),
        content: message
    }   
}