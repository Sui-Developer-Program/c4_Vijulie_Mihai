module tip_jar::tip_jar;

use sui::coin::Coin;
use sui::sui::SUI;

public struct TipJar has key, store {
    id: UID,
    owner: address,
    balance: u64,
    no_of_tips: u64
}

fun init(ctx: &mut TxContext) {
    
    let tip_jar = TipJar {
        id: object::new(ctx),
        owner: ctx.sender(),
        balance: 0,
        no_of_tips: 0
    };

    sui::transfer::share_object(tip_jar);

}

public fun tip(tip_jar: &mut TipJar, tip: Coin<SUI>) {
    tip_jar.balance = tip_jar.balance + sui::coin::value(&tip);
    tip_jar.no_of_tips = tip_jar.no_of_tips + 1;
    
    sui::transfer::public_transfer(tip, tip_jar.owner);
}

