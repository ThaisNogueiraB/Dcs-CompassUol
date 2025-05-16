import pytest
from  calculadora.calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

@pytest.mark.parametrize('num1, num2, esperado', [(2, 3, 6), (-1, 5, -5), (2.5,2,5.0),(0, 5, 0)])
def test_multiplicar(calc, num1, num2, esperado):
    assert calc.multiplicar(num1, num2) == esperado