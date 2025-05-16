import pytest
from calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

@pytest.mark.parametrize('num1, num2, esperado', [(10,2,5),(-10,2,-5),(5,2,2.5)])
def test_dividir(calc, num1, num2, esperado):
    assert calc.dividir(num1, num2) == esperado
