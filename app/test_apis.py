import pytest
from rest_framework.test import APIClient


pytestmark = pytest.mark.django_db


def test_sample_api():
    api_client = APIClient()
    url = "/"
    response = api_client.get(url)

    assert response.status_code == 200
