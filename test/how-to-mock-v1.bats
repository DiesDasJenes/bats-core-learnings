# I found this way to mock/stub at StackOverflow from this post: https://stackoverflow.com/a/52546483

setup() {
    # I always load everything
    load /test_frameworks/test_helper/bats-support/load
    load /test_frameworks/test_helper/bats-assert/load
    load /test_frameworks/test_helper/bats-file/load
    load /test_frameworks/test_helper/bats-mock/load
}

@test 'Stub date so it returns a specific date' {
	mocked_command="date"
	mock="$(mock_create)"
	mock_path="${mock%/*}"  # Parameter expansion to get the folder portion of the temp mock's path
	mock_file="${mock##*/}" # Parameter expansion to get the filename portion of the temp mock's path
	ln -sf "${mock_path}/${mock_file}" "${mock_path}/${mocked_command}"
	PATH="${mock_path}:$PATH" # Putting the stub at the beginning of the PATH so it gets picked up first
	mock_set_output "${mock}" "1460967598.184561556"
    # This is a test to assert that mocked_command stub is in the path and points the right place
    [[ "$(readlink -e $(which date))" == "$(readlink -e ${mock})" ]]

    run date 

    assert_output "1460967598.184561556"

	# Cleanup our stub and fixup the PATH
	unlink "${mock_path}/${mocked_command}"
	PATH="${PATH/${mock_path}:/}"
}
