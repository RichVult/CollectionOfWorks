import pytest

items = []

@pytest.fixture(autouse=True)
def setup_and_teardown():
    # any code you want to run before test goes before yield
    # this makes sure that items is empty before every test.
    items.clear()
    yield # yields to the unit test
    # any code you want to run after test goes after yield
    print(items)

class TestSuite:

    def test_00(self):
        '''
        This test will pass because it is the first test ran in the
        suite and nothing has been added to the `items` list yet.
        '''
        assert len(items) == 0

    def test_01(self):
        '''
        This test will pass because it is the second test ran in the
        suite and we updated the list to only have one item in it so
        the assertion will pass.
        '''
        items.append("Kevin")
        assert len(items) == 1

    def test_02(self):
        '''
        This test will pass because the `setup_and_teardown` function
        defined above ensures that the `items` list is empty prior to
        every test so the assertion will pass.
        '''
        assert len(items) == 0
        
    @pytest.mark.skip(reason="Can't test this right now.")
    def test_03(self):
        '''
        If at anytime you have a testcase that cannot possibly pass due
        to the either the function being tested not being complete or
        some other reason, you may mark function like above and the
        pytest framework will skip the test entirely.
        '''
        pass

    def test_04(self):
        '''
        If the function or logic you are running in your test raises an
        exception that you expect and you want to test an error scenario,
        you can use the method below of passing your test if the error is
        thrown.
        '''