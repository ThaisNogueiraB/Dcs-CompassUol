import pytest
from  calculadora.calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

@pytest.mark.parametrize('num1,num2,esperado',[(2,3,5),(-1,1,0),(1.5,2.5,4.0),(0,0,0)])
def test_somar(calc, num1, num2, esperado):
    assert calc.somar(num1, num2) == esperado