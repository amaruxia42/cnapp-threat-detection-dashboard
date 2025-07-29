from threat_detection.rules_engine import evaluate_event

def test_root_login():
    event = {
        "eventName": "ConsoleLogin",
        "userIdentity": {"userName": "root"}
    }
    result = evaluate_event(event)
    assert result is not None
    assert "Root account used" in result["findings"][0]