---
marp: true
theme: default
paginate: true
size: 16:9
title: What Solana Teaches Us About the Future of Scalable Blockchains
description: 15-minute conference talk about Solana, real load, TPS and next-gen blockchain infrastructure
footer: Solana · Scalable Blockchains
style: |
  section {
    background: radial-gradient(circle at 10% 20%, rgba(20, 241, 149, 0.18), transparent 28%),
                radial-gradient(circle at 90% 10%, rgba(153, 69, 255, 0.20), transparent 30%),
                #070a12;
    color: #f5f7ff;
    font-family: Inter, Manrope, Arial, sans-serif;
    padding: 58px 70px;
  }
  h1, h2 {
    color: #ffffff;
    letter-spacing: -0.04em;
  }
  h1 {
    font-size: 58px;
    line-height: 0.98;
  }
  h2 {
    font-size: 46px;
    line-height: 1.05;
    margin-bottom: 28px;
  }
  p, li {
    font-size: 27px;
    line-height: 1.25;
  }
  ul {
    padding-left: 32px;
  }
  strong {
    color: #14f195;
  }
  code {
    background: rgba(255, 255, 255, 0.10);
    color: #f5f7ff;
    padding: 0.08em 0.25em;
    border-radius: 6px;
  }
  footer {
    color: rgba(245, 247, 255, 0.55);
    font-size: 16px;
  }
  .kicker {
    color: #14f195;
    font-size: 23px;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }
  .muted {
    color: rgba(245, 247, 255, 0.68);
  }
  .big {
    font-size: 42px;
    line-height: 1.1;
    letter-spacing: -0.03em;
  }
  .grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
  }
  .card {
    background: rgba(255, 255, 255, 0.075);
    border: 1px solid rgba(255, 255, 255, 0.13);
    border-radius: 22px;
    padding: 28px;
  }
  .metric {
    color: #9945ff;
    font-size: 72px;
    font-weight: 800;
    letter-spacing: -0.06em;
  }
  .quote {
    border-left: 6px solid #14f195;
    padding-left: 28px;
    font-size: 39px;
    line-height: 1.15;
    letter-spacing: -0.035em;
  }
  .qr-slide {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 22px;
  }
  .qr-card {
    background: #ffffff;
    border-radius: 18px;
    padding: 18px;
    width: 340px;
    box-shadow: 0 18px 45px rgba(0, 0, 0, 0.26);
  }
  .qr-card img {
    display: block;
    width: 100%;
  }
  .repo-url {
    color: rgba(245, 247, 255, 0.74);
    font-size: 23px;
  }
  .thanks {
    color: #ffffff;
    font-size: 30px;
    font-weight: 700;
  }
---

# What Solana Teaches Us About the Future of Scalable Blockchains

**Solana as a case study:** real load, TPS vs usability, and requirements for next-gen infrastructure

---

## Solana is not a benchmark

<div class="quote">
A production stress test for the entire idea of high-throughput L1.
</div>

- users and wallets
- DEXes, arbitrage, MEV, memecoins
- RPC, validators, priority fees
- outages, postmortems, upgrades

---

## The thesis

<div class="big">
Future scalability is measured not by peak TPS, but by the reliability of a user action under load.
</div>

<br />

**Question:** can a user complete an important transaction when everyone else is trying to do the same?

---

## Usability metrics

<div class="grid">
  <div class="card">
    <strong>Inclusion latency</strong><br />
    time to inclusion in a block
  </div>
  <div class="card">
    <strong>Drop rate</strong><br />
    share of transactions lost before confirmation
  </div>
  <div class="card">
    <strong>Fee predictability</strong><br />
    accuracy of priority fee estimation
  </div>
  <div class="card">
    <strong>RPC availability</strong><br />
    endpoint stability
  </div>
</div>

---

## What real load looks like

Not "many transactions" in general.

It is when thousands of actors compete for the same outcome:

- be first into a token launch
- arbitrage DEX pools
- close a position on a price move
- send a swap before state changes

---

## Bottleneck moves

<div class="grid">
  <div class="card"><strong>Consensus</strong><br />forks, votes</div>
  <div class="card"><strong>Networking</strong><br />packet loss, QUIC</div>
  <div class="card"><strong>Scheduler</strong><br />account contention</div>
  <div class="card"><strong>Fee market</strong><br />priority fees</div>
  <div class="card"><strong>RPC</strong><br />overload, errors</div>
  <div class="card"><strong>Wallet UX</strong><br />retries, status</div>
</div>

---

## Low fees are a feature and an attack surface

<div class="big">
If transactions are cheap, spam is cheap too.
</div>

<br />

Case: April 30, 2022 (`04-30-22-solana-mainnet-beta-outage-report-mitigation`):
NFT mint bots, ~6M transaction requests/sec.

So the question is not "how to keep it nearly free always."

The question is: **how to serve normal load cheaply and fairly allocate scarcity at peaks**.

---

## Local fee markets

<div class="quote">
Payments shouldn't get more expensive just because one DEX pool got hot.
</div>

Idea: price contested state, not the whole network.

Ref: [Umbra Research, "Toward Multidimensional Solana Fees"](https://www.umbraresearch.xyz/writings/toward-multidimensional-solana-fees)

A local fee market tries to price concrete scarcity:

- accounts
- programs
- compute
- execution queues

---

## RPC is part of scalability

<div class="big">
When RPC degrades, the user thinks the blockchain degraded.
</div>

Case: Jan 8, 2023: Public RPC outage; block production was not impacted.

Study: [Anza, "Transaction Landing on TPU"](https://www.anza.xyz/blog/transaction-landing-on-tpu): latency + drop rate.

A production app must be able to:

- fetch a fresh blockhash
- track expiration via lastValidBlockHeight
- retry safely and rebuild the transaction

---

## Reliability > peak numbers

February 2024: Mainnet Beta halt of about 5 hours (`02-06-24-solana-mainnet-beta-outage-report`).

Official postmortem: bug in `LoadedPrograms`, legacy loader, and an infinite recompilation loop.

**Lesson:** a high-performance blockchain is a complex software system.

---

## Next-gen infrastructure requirements

- user-perceived reliability over vanity TPS
- local and transparent fee markets
- adaptive clients for normal/congested/degraded modes
- production-grade RPC and retries
- observability on inclusion, fees, latency, drops
- multi-client resilience

---

## Where Solana is moving

**Already on mainnet:**
- XDP — faster packet processing (Agave 3.0.9+)

**Roadmap, target Agave 4.1:**
- Alpenglow: consensus with ~150 ms confirmation
- 100M compute units per block: more capacity
- larger transactions: more composability

**In parallel:** Firedancer — a separate validator client (Jump Crypto).

---

## Closing takeaway

<div class="quote">
The future of scalable blockchains is not maximum TPS.
It is the ability to stay useful at the worst moment.
</div>

<br />

**The new metric:** can users reliably get important transactions included under real load?

---

## Slides and sources are on GitHub

<div class="qr-slide">
  <div class="qr-card">
    <img src="./repo-qr.svg" alt="QR code for GitHub repository" />
  </div>

  <div class="repo-url">github.com/kalaninja/solana-scalability-lessons</div>

  <div class="thanks">Thank you.</div>
</div>
