module DebtFilter
  def save_debts(debts)
    filter_debts(debts).map do |debt|
      debt.save
      debt
    end
  end

  private

  def filter_debts(debts)
    reverse_negatives(merge_debts(reverse_duplicates(debts)))
  end

  def unique_participants(debts)
    uniques = []
    debts.each do |debt|
      next if uniques.include?([debt.creditor, debt.debtor]) ||
              uniques.include?([debt.debtor, debt.creditor])
      uniques << [debt.debtor, debt.creditor]
    end
    uniques
  end

  def reverse_duplicates(debts)
    uniques = unique_participants(debts)
    debts.map do |debt|
      if uniques.include?([debt.debtor, debt.creditor])
        debt
      else
        Debt.new(debtor: debt.creditor,
                 creditor: debt.debtor, amount: -debt.amount)
      end
    end
  end

  def merge_debts(debts)
    debts.group_by { |debt| [debt.debtor, debt.creditor] }.map do |_, group|
      next if group.sum(&:amount).zero?
      Debt.new(debtor: group.first.debtor,
               creditor: group.first.creditor,
               amount: group.sum(&:amount))
    end.compact
  end

  def reverse_negatives(debts)
    debts.map do |debt|
      if debt.amount < 0
        Debt.new(debtor: debt.creditor,
                 creditor: debt.debtor, amount: debt.amount.abs)
      else
        debt
      end
    end
  end
end
