from functions import *
import pytest

def test_get_value():
    value = get_value()
    assert type(value) == str

def test_find_smallest_00():
    result = find_smallest([])
    assert result == None

def test_find_smallest_01():
    result = find_smallest([3, 4, -1])
    assert result == -1

def test_square_00():
    results = square(1, 2, 3)
    assert results == [1, 4, 9]

def test_square_01():
    results = square(2)
    assert results == [4]

def test_square_02():
    results = square()
    assert results == []

def test_get_average_00():
    result = average([1, 2, 3, 4])
    assert result == 2.5

def test_count_vowels_00():
    result = count_vowels("Hello world!")
    assert result == 3

def test_count_vowels_01():
    result = count_vowels("")
    assert result == 0