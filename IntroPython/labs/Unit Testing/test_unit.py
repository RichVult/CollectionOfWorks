from unit import add_five
import pytest

class TestSuite:

    def test_000(self):
        x = 5
        x = add_five(x)
        assert x == 10

    def test_01(self):
        x = None
        with pytest.raises(TypeError):
            x = add_five(x)