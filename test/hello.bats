load test_helper

@test "hellow" {
    . "$HELLO"
    run hello
    # becho "${status}:${output}"
    assert_success
    assert_output "hello"

}
