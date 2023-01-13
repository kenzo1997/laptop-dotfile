// NOTES: use k6 --linger to keep the connection open on port localhost:6565
import http from "k6/http";
import { sleep } from "k6";

function opt(stages) {
	return {
		insecureSkipTLSVerify: true,
		noConnectionReuse: false,
		stages: stages,
		threshold: {
			http_req_duration: ['p(99)<159']
		}
	}
}

function stressTestingOptions() {
	return [	
		{duration: '2m', target: 100},
		{duration: '5m', target: 100},
		{duration: '2m', target: 200},
		{duration: '5m', target: 200},
		{duration: '2m', target: 300},
		{duration: '5m', target: 300},
		{duration: '2m', target: 400},
		{duration: '5m', target: 400},
		{duration: '10m', target: 0}
	]
}

function SoikeTestingOptions() {
	return [
		{duration: '10s', target: 100},
		{duration: '1m', target: 100},
		{duration: '10s', target: 1400},
		{duration: '3m', target: 1400},
		{duration: '10s', target: 100},
		{duration: '3m', target: 100},
		{duration: '10s', target: 0},
	]
	
}

function LoadTestingOptions() {
  return [
		{ duration: '5m', target: 100 },
		{ duration: '10m', target: 100 },
		{ duration: '5m', target: 0 },
	]
}

function soakTesingoptions() {
	return [
		{ duration: '2m', target: 400 },
		{ duration: '3h56m', target: 400 },
		{ duration: '2m', target: 0 },
	]
}


let stages = stressTestingOptions()
export let options = opt(stages)

export default function() {
  let res = http.get("http://httpbin.org/");
  sleep(Math.random() * 2);
};

