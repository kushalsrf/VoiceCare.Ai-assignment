import time

def retry(fn, retries=3, backoff=2):
    for attempt in range(retries):
        try:
            return fn()
        except Exception as e:
            if attempt == retries - 1:
                raise e
            time.sleep(backoff ** attempt)
