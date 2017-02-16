(import hy)

(setv ops #{})

(defreader $ [op]
  (ops.add op)
  `nil)

(defn outfix [a op b]
  `(~op ~a ~b))

(defreader ^ [expr]
  (apply outfix expr))

(defn outfix-expand [expr]
  (print "O" expr)
  (outfix (expand (get expr 0)) (get expr 1) (expand (get expr 2))))

(defn expand [expr]
  (if (and (isinstance expr hy.HyExpression) (= (len expr) 3) (in ops (get expr 1)))
    (outfix-expand expr)
    expr))

(defreader % [expr]
  (outfix-expand expr))

