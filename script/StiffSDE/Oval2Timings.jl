
using StochasticDiffEq, DiffEqProblemLibrary, Random, Base.Threads
using DiffEqProblemLibrary.SDEProblemLibrary: importsdeproblems; importsdeproblems()
prob = DiffEqProblemLibrary.SDEProblemLibrary.oval2ModelExample(largeFluctuations=true,useBigs=false)
prob_func(prob,i,repeat) = remake(prob,seed=i)
prob = EnsembleProblem(remake(prob,tspan=(0.0,1.0)),prob_func=prob_func)
js = 16:21
dts = 1.0 ./ 2.0 .^ (js)
trajectories = 1000
fails = Array{Int}(undef,length(dts),3)
times = Array{Float64}(undef,length(dts),3)


sol = solve(prob,SRIW1(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-7),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SRIW1(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-7),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? Inf : adaptive_time
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SRI(error_terms=2),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-7),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SRI(error_terms=2),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-7),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SRI(),EnsembleThreads(),abstol=2.0^(-14),reltol=2.0^(-18),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SRI(),EnsembleThreads(),abstol=2.0^(-14),reltol=2.0^(-18),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SRI(tableau=StochasticDiffEq.constructSRIOpt1()),EnsembleThreads(),abstol=2.0^(-7),reltol=2.0^(-4),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SRI(tableau=StochasticDiffEq.constructSRIOpt1()),EnsembleThreads(),abstol=2.0^(-7),reltol=2.0^(-4),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-7),reltol=2.0^(-4),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-7),reltol=2.0^(-4),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-7),reltol=2.0^(-6),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-7),reltol=2.0^(-6),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-12),reltol=2.0^(-15),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-12),reltol=2.0^(-15),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-7),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-7),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-12),reltol=2.0^(-15),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI(),EnsembleThreads(),abstol=2.0^(-12),reltol=2.0^(-15),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI2(),EnsembleThreads(),abstol=2.0^(-12),reltol=2.0^(-15),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI2(),EnsembleThreads(),abstol=2.0^(-12),reltol=2.0^(-15),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI2(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-11),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI2(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-11),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


sol = solve(prob,SOSRI2(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-11),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=Threads.nthreads())
adaptive_time = @elapsed sol = solve(prob,SOSRI2(),EnsembleThreads(),abstol=2.0^(-13),reltol=2.0^(-11),maxiters=Int(1e11),qmax=1.125,save_everystep=false,trajectories=trajectories)
numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
best_adaptive_time = numfails != 0 ? adaptive_time : min(best_adaptive_time,adaptive_time)
println("The number of Adaptive Fails is $numfails. Elapsed time was $adaptive_time")


for j in eachindex(js)
  println("j = $j")
  sol =solve(prob,EM(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=Threads.nthreads())
  t1 = @elapsed sol = solve(prob,EM(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=trajectories)
  numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
  println("The number of Euler-Maruyama Fails is $numfails. Elapsed time was $t1")
  fails[j,1] = numfails
  times[j,1] = t1
end


for j in 1:4
  println("j = $j")
  sol =solve(prob,SRIW1(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=Threads.nthreads())
  t1 = @elapsed sol = solve(prob,SRIW1(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=trajectories)
  numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
  println("The number of SRIW1 Fails is $numfails. Elapsed time was $t1")
  fails[j,3] = numfails
  times[j,3] = t1
end


js = 17:21
dts = 1.0 ./2.0 .^ (js)
for j in 1:6
  println("j = $j")
  sol =solve(prob,ImplicitEM(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=Threads.nthreads())
  t1 = @elapsed sol = solve(prob,ImplicitEM(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=trajectories)
  numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
  println("The number of Implicit-EM Fails is $numfails. Elapsed time was $t1")
end


js = 17:21
dts = 1.0 ./ 2.0 .^(js)

for j in 1:6
  println("j = $j")
  sol =solve(prob,ImplicitRKMil(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=Threads.nthreads())
  t1 = @elapsed sol = solve(prob,ImplicitRKMil(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=trajectories)
  numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
  println("The number of Implicit-RKMil Fails is $numfails. Elapsed time was $t1")
end


for j in 1:6
  println("j = $j")
  sol =solve(prob,RKMil(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=Threads.nthreads())
  t1 = @elapsed sol = solve(prob,RKMil(),EnsembleThreads(),dt=dts[j],maxiters=Int(1e11),save_everystep=false,verbose=false,trajectories=trajectories)
  numfails = sum([Int(any(isnan,sol[i]) || sol[i].t[end] != 1) for i in 1:trajectories])
  println("The number of RKMil Fails is $numfails. Elapsed time was $t1")
  fails[j,2] = numfails
  times[j,2] = t1
end


using Plots
lw = 3
p2 = plot(dts,times,xscale=:log2,yscale=:log2,guidefont=font(16),tickfont=font(14),yguide="Elapsed Time (s)",xguide=L"Chosen $\Delta t$",top_margin=50px,linewidth=lw,lab=["Euler-Maruyama" "RK-Mil" "RosslerSRI"],legendfont=font(14))
plot!(dts,repmat([best_adaptive_time],11),linewidth=lw,line=:dash,lab="ESRK+RSwM3",left_margin=75px)
scatter!([2.0^(-20);2.0^(-20);2.0^(-18)],[times[5,1];times[5,2];times[3,3]],markersize=20,c=:red,lab="")
plot(p2,size=(800,800))


using DiffEqBenchmarks
DiffEqBenchmarks.bench_footer(WEAVE_ARGS[:folder],WEAVE_ARGS[:file])

