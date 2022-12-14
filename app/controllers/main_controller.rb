class MainController < ApplicationController
  
  def select
    render 'select'
  end
  
  def test
    @amount = params[:amount].to_i
    @subjectValue = params[:subjectValue]
    @errorSubject = params[:errorSubject]
    @scoreValue = params[:scoreValue]
    @errorScore = params[:errorScore]
  end


  def validate
    @subjectList = []
    @errorSubject = []

    @scoreList = []
    @errorScore = []
    # loop checking subjects
    for i in 1..params[:amount].to_i do 
      if(params["subject#{i}"] != "")
        @subjectList.push(params["subject#{i}"])
      else
        @subjectList.push("")
        @errorSubject.push(i.to_i)
      end
    end
    # loop checking scores
    for i in 1..params[:amount].to_i do 
      if(params["score#{i}"] != "")
        @scoreList.push(params["score#{i}"])
      else
        @scoreList.push("")
        @errorScore.push(i.to_i)
      end
    end

    # if there are no errors, redirect to display
    if(@errorSubject.length == 0 and @errorScore.length == 0)
      # Okay!
      for i in 0...@subjectList.length do
        @currSubject = Subject.where(name:@subjectList[i])
        puts "Current subject: #{@currSubject}"
        if(!@currSubject.blank?) #found
            @currSubject.update_all(score: @scoreList[i])
         else  # not found
            Subject.create(name: @subjectList[i],score: @scoreList[i])
         end
      
      end
      redirect_to action: 'display' ,subjectList: @subjectList, scoreList: @scoreList
    else
      # Error!
      redirect_to action: 'test', amount: params[:amount] , errorSubject: @errorSubject , subjectValue: @subjectList , errorScore: @errorScore , scoreValue: @scoreList
    end 
  end 

  def display
    @subjectList = params[:subjectList]
    @scoreList = params[:scoreList]

    @totalScore = 0
    @highestScore = @scoreList[0].to_i
    @scoreList.each do |score|
      if(score.to_i > @highestScore)
        @highestScore = score.to_i
      end
      @totalScore += score.to_i
    end
    
    @bestSubject = @subjectList[@scoreList.index(@highestScore.to_s)]
    @averageScore = @totalScore / @scoreList.length
  end

end
