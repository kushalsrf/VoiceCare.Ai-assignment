import time
from retry_policy import retry

def call_ai_service():
    # Placeholder for LiveKit / LLM call
    print("Calling AI service...")
    return True

def main():
    while True:
        retry(call_ai_service)
        time.sleep(5)

if __name__ == "__main__":
    main()
