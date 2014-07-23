define(["jquery"], function ($) {
    'use strict';

    var $container = $('#container'),
        $outputBox = $container.find('#output'),
        $submitBox = $container.find('#submit'),
        $inputBox = $container.find('#input');

    hideSubmitForm();
    $container.find('#scoreBoard').hide();

    function showSubmitForm(handler) {
        $submitBox.show().focus().change(handler);
    }

    function hideSubmitForm() {
        $submitBox.hide();
    }

    function disableInput() {
        $inputBox.prop('disabled', true);
    }

    function enableInput(handler) {
        $inputBox.change(handler);
    }

    function updateScoreTable(scores) {
        var $scoreList = $container.find('#scoreList');
        $scoreList.empty();
        $scoreList.append('<li><span class="title">Name</span><span class="title">Score</span></li>');
        scores.forEach(function (entry) {
            $scoreList.append('<li><span>' + entry.name + '</span><span>' + entry.score + '</span></li>');
        });
        $container.find('#scoreBoard').show();
    }

    function print(text) {
        $outputBox.append('<li>' + text + '</li>');
    }

    return {
        print: print,
        showSubmitForm: showSubmitForm,
        hideSubmitForm: hideSubmitForm,
        updateScoreTable: updateScoreTable,
        enableInput: enableInput,
        disableInput: disableInput
    }
});