import SwiftUI

/// Модификатор для создания эффекта ряби при изменении триггера
public struct RippleEffect<T: Equatable>: ViewModifier {
    var origin: CGPoint
    var trigger: T
    
    public init(at origin: CGPoint, trigger: T) {
        self.origin = origin
        self.trigger = trigger
    }
    
    public func body(content: Content) -> some View {
        let origin = origin
        let duration = duration
        
        content.keyframeAnimator(
            initialValue: 0,
            trigger: trigger
        ) { view, elapsedTime in
            view.modifier(RippleModifier(
                origin: origin,
                elapsedTime: elapsedTime,
                duration: duration
            ))
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(duration, duration: duration)
        }
    }
    
    var duration: TimeInterval { 3 }
}

/// Базовый модификатор эффекта ряби
public struct RippleModifier: ViewModifier {
    var origin: CGPoint
    var elapsedTime: TimeInterval
    var duration: TimeInterval
    
    var amplitude: Double = 12
    var frequency: Double = 15
    var decay: Double = 8
    var speed: Double = 1200
    
    public init(
        origin: CGPoint,
        elapsedTime: TimeInterval,
        duration: TimeInterval,
        amplitude: Double = 12,
        frequency: Double = 15,
        decay: Double = 8,
        speed: Double = 1200
    ) {
        self.origin = origin
        self.elapsedTime = elapsedTime
        self.duration = duration
        self.amplitude = amplitude
        self.frequency = frequency
        self.decay = decay
        self.speed = speed
    }
    
    public func body(content: Content) -> some View {
        let shader = ShaderLibrary.Ripple(
            .float2(origin),
            .float(elapsedTime),
            .float(amplitude),
            .float(frequency),
            .float(decay),
            .float(speed)
        )
        
        let maxSampleOffset = maxSampleOffset
        let elapsedTime = elapsedTime
        let duration = duration
        
        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: 0 < elapsedTime && elapsedTime < duration
            )
        }
    }
    
    var maxSampleOffset: CGSize {
        CGSize(width: amplitude, height: amplitude)
    }
}

// Вспомогательное расширение для удобного применения эффекта
public extension View {
    func rippleEffect<T: Equatable>(at origin: CGPoint, trigger: T) -> some View {
        modifier(RippleEffect(at: origin, trigger: trigger))
    }
} 