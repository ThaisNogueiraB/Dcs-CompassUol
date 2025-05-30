import pytest
from calculadora.calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

@pytest.mark.parametrize('num1, num2, esperado', [(5,3,2), (-1,-1,0), (3.5,1.5,2.0), (0,5,-5)])  
def test_subtrair(calc, num1, num2, esperado):
    assert calc.subtrair(num1, num2) == esperado