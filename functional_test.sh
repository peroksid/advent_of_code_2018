#!/usr/bin/env bats

@test "d1t1" {
    expected="430"
    result="$(./advent d1t1 inputs/1/1/input)"
    [ "$result" -eq "$expected" ]
}
