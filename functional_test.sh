#!/usr/bin/env bats

@test "d1t1" {
    [ "$(./advent d1t1 inputs/1/1/input)" = "430" ]
}

@test "d1t2" {
    [ "$(./advent d1t2 inputs/1/1/input)" = "462" ]
}

@test "d2t1" {
    [ "$(./advent d2t1 inputs/2/input)" = "6474" ]
}

@test "d2t2" {
    [ "$(./advent d2t2 inputs/2/input)" = "mxhwoglxgeauywfkztndcvjqr" ]
}

@test "d3t1" {
    [ "$(./advent d3t1 inputs/3/input.txt)" = "111326" ]
}

# @test "test" {
#     # result="$(./advent d2t2 inputs/2/input)"
#     # [ "mxhwoglxgeauywfkztndcvjqr" -eq "mxhwoglxgeauywfkztndcvjqr" ]
# }

# @test "d2t2" {
#     result="$(./advent d2t2 inputs/2/input)"
#     [ "|$result|" -eq "mxhwoglxgeauywfkztndcvjqr" ]
# }
