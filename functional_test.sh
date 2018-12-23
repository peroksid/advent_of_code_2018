#!/usr/bin/env bats

@test "d1t1" {
    [ "$(./advent d1t1 inputs/1/1/input)" -eq "430" ]
}

@test "d1t2" {
    [ "$(./advent d1t2 inputs/1/1/input)" -eq "462" ]
}

@test "d2t1" {
    [ "$(./advent d2t1 inputs/2/input)" -eq "6474" ]
}
