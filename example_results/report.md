# OCTO-EARTH - results report

Generated 2026-10-24 10:41:07  |  preset **hypothetical**

## Feasibility gate (analytic)

**FEASIBLE within this model (physically hypothetical scale)**

- Required slow-spiral delta-v 1 -> 2.7 AU: 11,658 m/s (Hohmann two-impulse: 10,997 m/s)
- Orbital energy change of Earth+Moon: 1.697e+33 J; angular momentum change 1.741e+40 kg m^2/s
- Average power just for the orbital energy change over 10,000 y: 5.377e+21 W  (= 3.10e+04 x all sunlight intercepted by Earth)
- Minimum launch energy with this reservoir: 1.664e+35 J -> average power 5.273e+23 W (= 1.38e-03 x total solar luminosity)
- Reaction mass needed at max speed: 1.415e+22 kg (0.193 lunar masses); available 3.000e+22 kg
- Max launch speed = 1.67% of c (non-relativistic model; error grows above ~10% c)
- [OK ] mass: needs launch speed 2.355e+06 m/s with ALL 3.00e+22 kg; max allowed 5.000e+06 m/s (mass-limited delta-v capacity 2.475e+04 m/s vs required 1.166e+04 m/s)
- [OK ] energy: minimum energy drawn 1.664e+35 J vs budget 3.000e+35 J
- [OK ] rate: at max packet rate and speed the transfer needs >= 1,771 years (mission 10,000 y)
- [OK ] combined: slowest speed meeting mass AND time limits 2.355e+06 m/s -> needs 3.000e+22 kg and 1.664e+35 J

## Physics checks

- PASS - 1 two-body motion vs Kepler: Kepler 1-orbit closure 1.4e-14; N-body vs Kepler after 1 y: 261.0 m
- PASS - 2 gravity of Sun / Earth / Moon / asteroid / fragments: Sun->Earth 6.133e-03, Moon->Earth 3.715e-05, Earth(+asteroid)->Moon 3.035e-03 m/s^2; asteroid mass scales Earth's pull by 1.005023; fragment(1e20 kg @1e6 km)->Earth 6.674e-09 m/s^2
- PASS - 3 equal and opposite forces: |sum m a| / sum|m a| = 7.5e-17
- PASS - 4+6 momentum & angular momentum in ejection: high-fidelity ejection: |dP|/(M_E v_E) = 2.0e-16 (round-off), |dL|/|L| = 1.8e-16; fast model |dP|/(dm u) = 1.2e-05 (incl. 1 ms of solar gravity)
- PASS - 5 energy accounting of propulsion: measured system energy change vs 1/2 mu u^2 - G dm M/R: rel diff 2.6e-08; drawn = KE/eta; budget never exceeded (tiny budget -> packet reduced to 1.11e+17 kg)
- PASS - 7 finite asteroid mass & fragment mass accounting: total mass + escaped mass - initial = 1.4e-16 (rel); merges=18, escaped 1.60e+19 kg; reservoir cannot go negative (5e18 kg reservoir -> ejected 5.00e+18 kg)
- PASS - 8 reversed ejection direction: prograde da = +0.0225 AU, retrograde da = -0.0217 AU (asymmetry 0.03)
- PASS - 9 fragment fall-back / escape / Earth impact: sub-escape packet falls back (no net recoil, energy lost): True; fast packet leaves the system and is ledgered as escaped: True; fragment aimed at Earth merges with momentum conserved: True
- PASS - 11 reproducibility (fixed seed): identical results for seed 7 (a=1.648587 AU)
- PASS - 13 viewer continuity (interpolation of recorded states): ballistic join between rows 1.1e-11 AU (no hidden jumps); viewer Hermite curve vs exact arc max 3.3e-05 AU; recoil |v_post - v_pre| matches recorded value to 5.2e-12; packet path bends 6.4e-05 (relative) from a straight line after 1 day under solar gravity
- PASS - 14 Moon in the fast (training) model: 1 y without thrust: Earth-Moon distance fast 363,297-405,504 km vs N-body 361,807-399,330 km (max diff 10,422 km); Moon's orbital phase drifts 22 deg/yr (Sun's tide on the Moon not in the fast model); barycentre diff 99 km; Earth wobble from the Moon's pull 4,874 km; recoil changes the Earth-Moon relative velocity by Earth's recoil only (rel. error 6.4e-12); Moon bound: yes
- PASS - 10 integrator convergence: Earth position error after 10 y at dt 12/6/3 h: 498635/37700/2360 m (ratios 13.2, 16.0; 4th order -> 16)
- PASS - 10b energy / angular-momentum drift: 100 y ballistic: |dE/E| = 9.2e-12, |dL|/|L| = 1.1e-15
- PASS - 12 fast model vs high-fidelity N-body: heuristic, 1,500 y: a fast 2.24011 vs high-fidelity 2.24011 AU (rel 1.5e-08), |de| 6.1e-08

## Training

State finished, 1000 episodes, 79105 timesteps, 254 s wall time (fast model).
Best model: episode 750, selection = lexicographic: success rate, then lowest terminal orbit error, then lowest energy use (deterministic, seeds 1001-1002).
Hyperparameters: {"algorithm": "PPO (Stable-Baselines3)", "net_arch": [64, 64], "n_steps": 1000, "batch_size": 200, "n_epochs": 10, "learning_rate": 0.0003, "gamma": 0.995, "gae_lambda": 0.95, "log_std_init": -0.5, "seed": 1}
Deterministic eval at selection: {"success_rate": 1.0, "error": 0.02863199916328861, "energy_frac": 0.7617570461917231, "years": 5800.0, "reward": 199.31709250263506, "a_au": 2.6776247017938206, "e": 0.007735029521003257, "score": [1.0, -0.0286, -0.7617570461917231], "episode": 750, "timesteps": 62750}

## Comparison (physical metrics; reward shown separately)

| policy | fast success (3 seeds) | hi-fi result | hi-fi a [AU] | e | years | asteroid used | energy used [J] | validated | reward (hi-fi) |
|---|---|---|---|---|---|---|---|---|---|
| No ejection | 0% | deadline | 1.0000 | 0.0167 | 10,000 | 0.0% | 0.000e+00 | False | -53.7 |
| Hand-designed heuristic | 100% | success | 2.7000 | 0.0080 | 3,600 | 95.0% | 1.752e+35 | True | 200.3 |
| Best PPO model | 100% | success | 2.6675 | 0.0079 | 5,800 | 74.1% | 2.294e+35 | True | 199.1 |

## Best model: final orbit vs target (high-fidelity run)

| criterion | value | required | result |
|---|---|---|---|
| Semi-major axis a | 2.6675 AU | 2.7 +/- 0.05 | PASS |
| Eccentricity e | 0.00788  | <= 0.05 | PASS |
| Inclination | 0.040238 deg | <= 5.0 | PASS |
| Arrival time | 5800 yr | <= 10000 | PASS |
| Moon still bound | True  | yes | PASS |
| Stays in the target window for 200 yr without thrust (largest deviation of a from target) | 0.032549 AU | <= 0.05 AU, e <= 0.05, Moon bound | PASS |

## Best model: decisions (high-fidelity run)

Classes: helped 58

| years | throttle | packets | packet kg | speed km/s | prograde cos | dv m/s | da AU | e | effect |
|---|---|---|---|---|---|---|---|---|---|
| 0-100 | 0.57 | 800 | 4.53e+20 | 3644 | 1.00 | 271.6 | +0.0185 | 0.0165 | helped |
| 100-200 | 0.67 | 800 | 5.36e+20 | 4066 | 0.99 | 358.6 | +0.0250 | 0.0161 | helped |
| 200-300 | 0.39 | 800 | 3.15e+20 | 2869 | 0.99 | 148.9 | +0.0106 | 0.0160 | helped |
| 300-400 | 0.62 | 800 | 4.95e+20 | 3450 | 1.00 | 281.3 | +0.0207 | 0.0158 | helped |
| 400-500 | 0.51 | 800 | 4.07e+20 | 3284 | 0.99 | 220.3 | +0.0166 | 0.0156 | helped |
| 500-600 | 0.49 | 800 | 3.93e+20 | 3227 | 1.00 | 209.0 | +0.0162 | 0.0155 | helped |
| 600-700 | 0.64 | 800 | 5.08e+20 | 3943 | 0.99 | 330.2 | +0.0262 | 0.0152 | helped |
| 700-800 | 0.39 | 800 | 3.11e+20 | 2849 | 0.99 | 146.0 | +0.0119 | 0.0150 | helped |
| 800-900 | 0.60 | 800 | 4.82e+20 | 3386 | 1.00 | 268.8 | +0.0224 | 0.0149 | helped |
| 900-1000 | 0.60 | 800 | 4.82e+20 | 3914 | 0.99 | 310.9 | +0.0266 | 0.0146 | helped |
| 1000-1100 | 0.58 | 800 | 4.66e+20 | 3675 | 0.99 | 281.8 | +0.0249 | 0.0144 | helped |
| 1100-1200 | 0.44 | 800 | 3.48e+20 | 3073 | 1.00 | 176.4 | +0.0161 | 0.0142 | helped |
| 1200-1300 | 0.67 | 800 | 5.4e+20 | 3843 | 1.00 | 341.7 | +0.0320 | 0.0140 | helped |
| 1300-1400 | 0.39 | 800 | 3.1e+20 | 2992 | 0.99 | 153.0 | +0.0147 | 0.0139 | helped |
| 1400-1500 | 0.65 | 800 | 5.21e+20 | 3556 | 1.00 | 305.2 | +0.0302 | 0.0137 | helped |
| 1500-1600 | 0.35 | 800 | 2.84e+20 | 2697 | 1.00 | 126.1 | +0.0128 | 0.0136 | helped |
| 1600-1700 | 0.54 | 800 | 4.3e+20 | 3121 | 1.00 | 221.4 | +0.0230 | 0.0134 | helped |
| 1700-1800 | 0.53 | 800 | 4.22e+20 | 3528 | 1.00 | 245.3 | +0.0260 | 0.0133 | helped |
| 1800-1900 | 0.52 | 800 | 4.18e+20 | 3468 | 1.00 | 239.0 | +0.0261 | 0.0130 | helped |
| 1900-2000 | 0.42 | 800 | 3.33e+20 | 2865 | 1.00 | 157.0 | +0.0176 | 0.0129 | helped |
| 2000-2100 | 0.60 | 800 | 4.77e+20 | 3672 | 1.00 | 288.8 | +0.0332 | 0.0127 | helped |
| 2100-2200 | 0.36 | 800 | 2.86e+20 | 2689 | 1.00 | 126.8 | +0.0150 | 0.0126 | helped |
| 2200-2300 | 0.62 | 800 | 4.96e+20 | 3749 | 1.00 | 306.4 | +0.0370 | 0.0123 | helped |
| 2300-2400 | 0.33 | 800 | 2.6e+20 | 2497 | 1.00 | 107.2 | +0.0133 | 0.0122 | helped |
| 2400-2500 | 0.54 | 800 | 4.3e+20 | 3188 | 1.00 | 226.1 | +0.0287 | 0.0121 | helped |
| 2500-2600 | 0.50 | 800 | 3.97e+20 | 3378 | 1.00 | 220.9 | +0.0288 | 0.0118 | helped |
| 2600-2700 | 0.40 | 800 | 3.18e+20 | 2610 | 1.00 | 137.0 | +0.0183 | 0.0117 | helped |
| 2700-2800 | 0.57 | 800 | 4.6e+20 | 3289 | 0.99 | 249.3 | +0.0338 | 0.0115 | helped |
| 2800-2900 | 0.44 | 800 | 3.55e+20 | 2969 | 0.99 | 173.9 | +0.0242 | 0.0115 | helped |
| 2900-3000 | 0.42 | 800 | 3.35e+20 | 2735 | 1.00 | 151.0 | +0.0217 | 0.0114 | helped |
| 3000-3100 | 0.56 | 800 | 4.45e+20 | 3531 | 1.00 | 259.1 | +0.0380 | 0.0110 | helped |
| 3100-3200 | 0.39 | 800 | 3.1e+20 | 2562 | 1.00 | 131.1 | +0.0198 | 0.0110 | helped |
| 3200-3300 | 0.62 | 800 | 4.94e+20 | 3764 | 0.99 | 306.9 | +0.0473 | 0.0108 | helped |
| 3300-3400 | 0.42 | 800 | 3.35e+20 | 3201 | 0.99 | 176.7 | +0.0281 | 0.0106 | helped |
| 3400-3500 | 0.53 | 800 | 4.27e+20 | 3109 | 0.99 | 219.1 | +0.0357 | 0.0105 | helped |
| 3500-3600 | 0.34 | 800 | 2.75e+20 | 2511 | 1.00 | 113.8 | +0.0192 | 0.0105 | helped |
| 3600-3700 | 0.58 | 800 | 4.61e+20 | 3518 | 1.00 | 267.6 | +0.0462 | 0.0101 | helped |
| 3700-3800 | 0.44 | 800 | 3.51e+20 | 3043 | 0.98 | 176.2 | +0.0309 | 0.0101 | helped |
| 3800-3900 | 0.39 | 800 | 3.1e+20 | 2592 | 1.00 | 132.5 | +0.0242 | 0.0100 | helped |
| 3900-4000 | 0.54 | 800 | 4.32e+20 | 3430 | 1.00 | 244.5 | +0.0457 | 0.0098 | helped |
| 4000-4100 | 0.47 | 800 | 3.73e+20 | 3174 | 0.98 | 195.2 | +0.0371 | 0.0095 | helped |
| 4100-4200 | 0.38 | 800 | 3.05e+20 | 2426 | 0.99 | 122.0 | +0.0240 | 0.0095 | helped |
| 4200-4300 | 0.43 | 800 | 3.44e+20 | 2596 | 1.00 | 147.2 | +0.0296 | 0.0094 | helped |
| 4300-4400 | 0.51 | 800 | 4.11e+20 | 3114 | 0.98 | 211.4 | +0.0427 | 0.0094 | helped |
| 4400-4500 | 0.38 | 800 | 3e+20 | 2873 | 1.00 | 142.3 | +0.0301 | 0.0092 | helped |
| 4500-4600 | 0.54 | 800 | 4.28e+20 | 3084 | 0.97 | 218.0 | +0.0463 | 0.0090 | helped |
| 4600-4700 | 0.33 | 800 | 2.61e+20 | 2284 | 0.99 | 98.5 | +0.0219 | 0.0090 | helped |
| 4700-4800 | 0.51 | 800 | 4.05e+20 | 2757 | 0.98 | 184.3 | +0.0411 | 0.0090 | helped |
| 4800-4900 | 0.42 | 800 | 3.38e+20 | 3179 | 0.99 | 177.6 | +0.0413 | 0.0087 | helped |
| 4900-5000 | 0.46 | 800 | 3.66e+20 | 2777 | 0.97 | 168.0 | +0.0392 | 0.0086 | helped |
| 5000-5100 | 0.41 | 800 | 3.3e+20 | 2599 | 0.98 | 141.8 | +0.0341 | 0.0086 | helped |
| 5100-5200 | 0.50 | 800 | 4.04e+20 | 3369 | 0.98 | 224.5 | +0.0555 | 0.0084 | helped |
| 5200-5300 | 0.28 | 800 | 2.25e+20 | 2087 | 1.00 | 77.4 | +0.0200 | 0.0083 | helped |
| 5300-5400 | 0.45 | 800 | 3.63e+20 | 2626 | 1.00 | 157.6 | +0.0415 | 0.0082 | helped |
| 5400-5500 | 0.48 | 800 | 3.82e+20 | 3096 | 0.96 | 195.3 | +0.0509 | 0.0080 | helped |
| 5500-5600 | 0.33 | 800 | 2.64e+20 | 2213 | 0.98 | 96.4 | +0.0263 | 0.0080 | helped |
| 5600-5700 | 0.52 | 800 | 4.13e+20 | 3080 | 0.95 | 210.0 | +0.0566 | 0.0080 | helped |
| 5700-5800 | 0.27 | 800 | 2.12e+20 | 2170 | 1.00 | 76.1 | +0.0221 | 0.0079 | helped |

## Training episode outcomes (stochastic exploration)

- resources_exhausted: 914 (All asteroid mass or all propulsion energy was used before reaching the target.)
- deadline: 86 (Mission time ran out before the target was reached.)

> This is the best policy found in this training run, judged on a few deterministic test episodes. It is not proven to be globally optimal; other strategies (e.g. the heuristic) can be better on some measures.
> Reward is only the scoring rule used to train the agent. Mission success is judged separately from physics: final a, e and inclination, a ballistic stability check, and the Moon staying bound.

## Why the best model behaves as it does

- RESULT: the best PPO model reached the target in the high-fidelity N-body check: a = 2.6675 AU, e = 0.0079 after 5,800 simulated years, and the orbit stayed within tolerance for 200 ballistic years with the Moon bound.
- Direction: the impulse-weighted recoil direction on Earth has along-track (prograde) cosine 0.99, |radial| 0.06, |out-of-plane| 0.08; 0.0% of the impulse was retrograde. Along-track thrust raises orbital energy fastest (Gauss: da/dt = 2 a^2 v f_T / mu, with f_T the along-track acceleration); radial/normal components mostly waste reaction mass.
- Launch speed: mass-weighted mean 3.205e+06 m/s vs 2.355e+06 m/s, the minimum-energy speed that uses the whole asteroid (heuristic uses 2.480e+06 m/s). Momentum per joule falls as 2/u, so a lower speed saves energy but costs more mass.
- Most effective decisions (largest da per 100-y interval, fast model): t=5800 y: da=+0.0626 AU (prograde cos 0.95, u=3.24e+06 m/s, throttle 0.52); t=5400 y: da=+0.0621 AU (prograde cos 0.99, u=3.36e+06 m/s, throttle 0.53); t=4500 y: da=+0.0616 AU (prograde cos 0.99, u=3.65e+06 m/s, throttle 0.61). Least effective: t=300 y: da=+0.0106 AU (prograde cos 0.99, u=2.87e+06 m/s, throttle 0.39). At similar throttle, gains per interval grow with a, because at constant thrust acceleration da/dt ~ a^1.5.
- Timing: ejected in 58 of 58 decision intervals (first 100 y, last 5800 y). It keeps thrusting until the orbit enters the target window, where the episode ends.
- Resources (high-fidelity run): PPO used 74.1% of the asteroid and 76.5% of the energy budget; heuristic 95.0% / 58.4%; no-ejection baseline stays at a = 1.0000 AU.
- Versus the hand-designed heuristic: PPO arrives slower (5,800 vs 3,600 y) and uses more energy.
- This is the best model found in the tested training run, not a proven global optimum.

## Conservation (high-fidelity runs)

- No ejection: energy residual -4.6e-12 (rel. to |E0|), momentum 1.0e-12, angular momentum 4.3e-13, mass 0.0e+00; fragment merges 0
- Hand-designed heuristic: energy residual 1.6e-06 (rel. to |E0|), momentum 1.2e-13, angular momentum 7.0e-14, mass 1.4e-16; fragment merges 0
- Best PPO model: energy residual 1.7e-06 (rel. to |E0|), momentum 2.0e-13, angular momentum 3.3e-14, mass 0.0e+00; fragment merges 0

## Limitations

See README.md - simplified prototype, not a validated engineering or climate model.
