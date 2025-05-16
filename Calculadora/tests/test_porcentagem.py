import pytest
from  calculadora.calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

@pytest.mark.parametrize("num1, num2, esperado",[(200,0,0),(200,50,100),(200,100,200),(1000,12.5,125)])
def test_porcentagem(calc, num1, num2, esperado):
    assert calc.porcentagem(num1, num2) == esperado