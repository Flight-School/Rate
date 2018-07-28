import Foundation
import Rate

let niagaraFallsWaterFlow = Rate<UnitVolume, UnitDuration>(value: 84760, unit: .cubicFeet, per: .seconds)
let oneDay = Measurement<UnitDuration>(value: 24, unit: .hours)

(niagaraFallsWaterFlow * oneDay).converted(to: .megaliters)
