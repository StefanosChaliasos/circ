#!/usr/bin/env zsh

set -ex

disable -r time

cargo build --release --example circ

BIN=./target/release/examples/circ

case "$OSTYPE" in 
    darwin*)
        alias measure_time="gtime --format='%e seconds %M kB'"
    ;;
    linux*)
        alias measure_time="time --format='%e seconds %M kB'"
    ;;
esac

function mpc_test {
    parties=$1
    zpath=$2
    RUST_BACKTRACE=1 measure_time $BIN --parties $parties $zpath mpc
}

# build mpc arithmetic tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_add.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_sub.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_mult.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_mult_add_pub.zok

mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_int_equals.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_int_greater_than.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_int_greater_equals.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_int_less_than.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/arithmetic_tests/2pc_int_less_equals.zok

# build mpc nary arithmetic tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/nary_arithmetic_tests/2pc_nary_arithmetic_add.zok

# build mpc bitwise tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/bitwise_tests/2pc_bitwise_and.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/bitwise_tests/2pc_bitwise_or.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/bitwise_tests/2pc_bitwise_xor.zok

# build mpc boolean tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/boolean_tests/2pc_boolean_and.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/boolean_tests/2pc_boolean_or.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/boolean_tests/2pc_boolean_equals.zok

# build mpc nary boolean tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/nary_boolean_tests/2pc_nary_boolean_and.zok

# build ite tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/ite_tests/2pc_ite_ret_bool.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/ite_tests/2pc_ite_ret_int.zok

# build mpc const tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/const_tests/2pc_const_arith.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/const_tests/2pc_const_bool.zok

# build mpc array tests
# mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/array_tests/2pc_array_sum.zok
# mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/array_tests/2pc_array_ret.zok

# build mps loop tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/loop_tests/2pc_loop_sum.zok

# build mpc function tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/function_tests/2pc_function_sum.zok

# build mpc shift tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/shift_tests/2pc_lhs.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/shift_tests/2pc_rhs.zok

# build mpc misc tests
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/2pc_millionaire.zok
mpc_test 2 ./examples/ZoKrates/mpc/unit_tests/2pc_conv.zok

# mpc_test 2 ./examples/ZoKrates/mpc/hycc_benchmarks/biomatch.zok