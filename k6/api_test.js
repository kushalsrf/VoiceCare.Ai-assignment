import http from "k6/http";
import { check, sleep } from "k6";
import { Trend, Rate } from "k6/metrics";

export let latency95 = new Trend("latency_p95");
export let errorRate = new Rate("errors");

export let options = {
  stages: [
    { duration: "2m", target: 20 },   
    { duration: "5m", target: 50 },   
    { duration: "2m", target: 0 },   
  ],
  thresholds: {
    http_req_failed: ["rate<0.005"],    
    http_req_duration: ["p(95)<300"],    
  },
};

export default function () {
  const res = http.get("https://api.example.com/health");

  latency95.add(res.timings.duration);
  errorRate.add(res.status !== 200);

  check(res, {
    "status is 200": (r) => r.status === 200,
  });

  sleep(1);
}
