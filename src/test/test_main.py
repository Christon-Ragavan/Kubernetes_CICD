import unittest
try:
    from src.main import AppFeature
except:
    from app.main import AppFeature


class TestMain(unittest.TestCase):

    def test_adding(self):
        output = AppFeature.adding(5, 5)
        expected_output = 10
        self.assertEqual(expected_output, output)


if __name__ == '__main__':
    unittest.main()
