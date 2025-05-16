import pytest
from  calculadora.calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

@pytest.mark.parametrize('num1, num2, esperado', [(2, 3, 8), (-2, 3,-8), (2.5,2,6.25),(0,5,0)])
def test_potencia(calc, num1, num2, esperado):
    assert calc.potencia(num1, num2) == esperado

    '''
 Informações sobre a implementação foram fornecidas pelo ChatGPT (OpenAI)
        em conversa no dia 16 de Maio de 2025.
    '''