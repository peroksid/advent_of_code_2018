#!/usr/bin/env bats

@test "d1t1" {
    [ "$(./advent d1t1 inputs/1/1/input)" -eq "430" ]
}

@test "d1t2" {
    expected="462"
    [ "$(./advent d1t2 inputs/1/1/input)" -eq "462" ]
}
